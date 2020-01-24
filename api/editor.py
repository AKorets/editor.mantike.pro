# coding=utf-8
from os import urandom
from math import pi
from uuid import uuid4
from json import dumps
from cgi import parse_qs
from base62 import encode
from cards import Cards

_404 = '<div style="text-align:center;margin-top:20%;"><h1>¯\_(ツ)_/¯</h1><h1>404</h1></div>'


def coin():
    return ord(urandom(1)) % 2


def angle():
    return [0, pi][coin()]


def translate(value, leftMin, leftMax, rightMin, rightMax):
    # Figure out how 'wide' each range is
    leftSpan = leftMax - leftMin
    rightSpan = rightMax - rightMin

    # Convert the left range into a 0-1 range (float)
    valueScaled = float(value - leftMin) / float(leftSpan)

    # Convert the 0-1 range into a value in the right range.
    return int(rightMin + (valueScaled * rightSpan))


def mix_handler(environ, start_response):
    if environ['REQUEST_METHOD'] == 'POST':
        start_response('200 OK', [('Content-Type', 'text/plain')])
        data = environ['wsgi.input'].read(int(environ['CONTENT_LENGTH']))[22:].decode('base64')
        fn = encode(uuid4().int) + '.png'
        with open('../public/spreads/' + fn, 'wb') as f:
            f.write(data)
        yield fn
    else:
        start_response('404 Not Found', [('Content-Type', 'text/html')])
        yield _404


def foretell_handler(environ, start_response):
    try:
        n = int(parse_qs(environ['QUERY_STRING']).get('n', ['1'])[0])
        isWithReversed = int(parse_qs(environ['QUERY_STRING']).get('reversed', ['1'])[0])
        suitcase = parse_qs(environ['QUERY_STRING']).get('suitcase', ['tarot'])[0]
    except ValueError:
        yield _404
    C = len(Cards[suitcase])
    if n > C:
        yield _404
    start_response('200 OK', [('Content-Type', 'application/json')])
    spread = []
    cs = []
    # TODO optimize
    while len(cs) < n:
        c = Cards[suitcase][translate(ord(urandom(1)), 0, 256, 0, C)]
        if not c in cs:
            cs.append(c)
            spread.append({
                'card': c,
                'angle': angle() if isWithReversed else 0
            })
    yield dumps(spread)
