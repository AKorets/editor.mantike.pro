def format_card_names(seq, prefix='', pad=2):
    return map(lambda x: ('{0}{1:0' + str(pad) + 'd}').format(prefix, x), seq)


def g(suit='', count=14, start=1, pad=2):
    return format_card_names(range(start, count + start), suit, pad)


def gs(suits=['w', 'c', 's', 'p'], count=14, start=1):
    return reduce(lambda x, y: x + y, map(lambda s: g(s, count, start), suits))


Cards = {
    'major': g('m', 22, 0),
    'tarot': g('m', 22, 0) + gs(),
    'chairs': g('m', 24, 0) + gs(),
    'elisium': g('m', 22, 0) + g('n', 22, 0) + gs(count=15) + g('x', 8),
    'monosov': g('m', 22) + gs(),
    'alone': g(count=36) + ['12-1', '28-1', '29-1'],
    'roses': g(count=36) + ['13-1', '28-1', '29-1'],
    'rocambole': ['m00-1', 'm00-2', 'm00-3'] + g('m', 22, 1) + gs(count=16),
    'petrak': ['m00', 'm01-1', 'm01-2'] + g('m', 20, 2) + gs(),
    'inspiration': g('m', 25, 0) + gs(count=15),
    'steele': g('m', 28, 0) + gs(count=15),
    'astromyth': gs() + ['man', 'woman'],
    'symbolon': g(count=78),
    'psychic': g('m', 22, 0) + gs(count=9) + g('x', 7),
    '78': g(count=78),
    '80': g(count=80),
    '81': g(count=81),
    '72': g(count=72),
    '60': g(count=60),
    '720': g(count=72, start=0),
    '90': g(count=90, start=0),
    '70': g(count=70),
    '64': g(count=64),
    '52': g(count=52),
    '520': g(count=52, start=0),
    '50': g(count=50),
    '56': g(count=56),
    '48': g(count=48),
    '45': g(count=45),
    '47': g(count=47),
    '40': g(count=40),
    '36': g(count=36),
    '360': g(count=36, start=0),
    '44': g(count=44),
    '35': g(count=35, start=0),
    '37': g(count=37),
    '39': g(count=39),
    '370': g(count=37, start=0),
    '32': g(count=32),
    '22': g(count=22, start=0),
    '20': g(count=20),
    '103': g(count=103, pad=3),
    '108': g(count=108, pad=3),
    '155': g(count=155, pad=3),
    'paracelsus': g('m', 22, 0) + gs() + g('a', 9),
    'roma': gs(count=13),
    'futhark': g(count=24),
    'futhork': g(count=33),
    'futhark+': g(count=25),
    'stardust': g(count=100, start=0) + ['100', '101', '102'],
    'healing': g(count=90),
    'cosmic': g('m', 22, 0) + gs() + ['m06-1', 'm06-2'],
    'alice': g('m', 22, 0) + gs() + ['m06-1', 'w07-1'],
    'clover': g('m', 22, 0) + gs() + ['m06-1'],
    'daniloff': g('m', 22, 0) + gs() + ['m08-1', 'm11-1', 'white'],
    'maroon': g('m', 23, 0) + gs(),
    'akron': g('m', 24, 0) + gs(),
    'shapeshifter': g('m', 25, 0) + gs(),
    'sangre': g('m', 25, 0) + ['m11-2'] + gs(),
    'soulbreath': g('m', 22, 0) + ['m01-1', 'm03-1', 'm11-1', 'm15-1'] + gs(),
    'reverie': g(count=40) + ['12-1', '28-1', '29-1'],
    'neworlean': ['m00-1'] + g('m', 22, 0) + gs(),
    'wild': g('m', 22, 0) + gs(),
    'viceverse': g('m', 22, 0) + gs() + g('mb', 22, 0) + gs(['wb', 'cb', 'sb', 'pb']),
    'warlock': g('m', 22, 0) + gs(['angel', 'body', 'demon', 'planet', 'sin'], 7),
}