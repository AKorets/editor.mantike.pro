repeat = (pattern, count) ->
    return '' if count < 1
    result = ''
    while count > 0
        result += pattern if count & 1
        count >>= 1
        pattern += pattern
    result

padding_zero = (x, n) ->
  String(repeat("0", n) + x).slice(-1 * n)

format_card_names = (seq, prefix, pad=2) ->
  (prefix + padding_zero(x, pad) for x in seq)

g = (suit='', count=14, start=1, pad=2) ->
  format_card_names [start...(start+count)], suit, pad


module.exports =
  major:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 22, 0
  tarot:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 22, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  elisium:
    major:
      label: 'Major 1'
      icon: '/major.png'
      cards: g 'm', 22, 0
    najor:
      label: 'Major 2'
      icon: '/major.png'
      cards: g 'n', 22, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w', 15
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c', 15
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's', 15
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p', 15
    xxx:
      label: '&oplus;'
      cards: g 'x', 8
  monosov:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 22
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  rocambole:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: ['m00-1', 'm00-2', 'm00-3'].concat(g 'm', 22, 1)
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w', 16
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c', 16
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's', 16
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p', 16
  petrak:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: ['m00', 'm01-1', 'm01-2'].concat(g 'm', 20, 2)
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  inspiration:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 25, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w', 15
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c', 15
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's', 15
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p', 15
  steele:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 28, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w', 15
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c', 15
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's', 15
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p', 15
  astromyth:
    wands:
      label: '<span style="color:black;">&clubs;</span>'
      cards: g 'w'
    cups:
      label: '<span style="color:red;">&hearts;</span>'
      cards: g 'c'
    swords:
      label: '<span style="color:black;">&spades;</span>'
      cards: g 's'
    discs:
      label: '<span style="color:red;">&diams;</span>'
      cards: g 'p'
    blanks:
      label: '<span style="color:blue;">&equiv;</span>'
      cards: ['man', 'woman']
  symbolon:
    root:
      label: '<span style="font-size:xx-large;">&#10050;</span>'
      cards: ['01','02','03','04','05','06','07','08','09','10','11','12']
    aries:
      label: '♈'
      cards: ['34','35','13','24','36','37','38','39','40','41','42']
      place: 'h'
    taurus:
      label: '♉'
      cards: ['34','43','14','25','44','45','46','47','48','49','50']
      place: 'h'
    gemini:
      label: '♊'
      cards: ['35','43','15','26','51','52','53','54','55','56','57']
      place: 'h'
    cancer:
      label: '♋'
      cards: ['13','14','15','16','17','18','19','20','21','22','23']
      place: 'h'
    leo:
      label: '♌'
      cards: ['24','25','26','16','27','28','29','30','31','32','33']
      place: 'h'
    virgo:
      label: '♍'
      cards: ['36','44','51','17','27','58','59','60','61','62','63']
      place: 'h'
    libra:
      label: '♎'
      cards: ['37','45','52','18','28','58','64','65','66','67','68']
      place: 'h'
    scorpio:
      label: '♏'
      cards: ['38','46','53','19','29','59','64','69','70','71','72']
      place: 'h'
    sagittarius:
      label: '♐'
      cards: ['39','47','54','20','30','60','65','69','73','74','75']
      place: 'h'
    capricorn:
      label: '♑'
      cards: ['40','48','55','21','31','61','66','70','73','76','77']
      place: 'h'
    aquarius:
      label: '♒'
      cards: ['41','49','56','22','32','62','67','71','74','76','78']
      place: 'h'
    pisces:
      label: '♓'
      cards: ['42','50','57','23','33','63','68','72','75','77','78']
      place: 'h'
  45:
    1:
      cards: g '', 9
    2:
      cards: g '', 9, 10
    3:
      cards: g '', 9, 19
    4:
      cards: g '', 9, 28
    5:
      cards: g '', 9, 37
  47:
    1:
      cards: g '', 9
    2:
      cards: g '', 9, 10
    3:
      cards: g '', 9, 19
    4:
      cards: g '', 9, 28
    5:
      cards: g '', 11, 37
  36:
    1:
      cards: g '', 9
    2:
      cards: g '', 9, 10
    3:
      cards: g '', 9, 19
    4:
      cards: g '', 9, 28
  360:
    1:
      cards: g '', 9, 0
    2:
      cards: g '', 9, 9
    3:
      cards: g '', 9, 18
    4:
      cards: g '', 9, 27
  37:
    1:
      cards: g '', 9
    2:
      cards: g '', 9, 10
    3:
      cards: g '', 9, 19
    4:
      cards: g '', 10, 28
  39:
    1:
      cards: g '', 10
    2:
      cards: g '', 10, 10
    3:
      cards: g '', 10, 20
    4:
      cards: g '', 9, 30
  370:
    1:
      cards: g '', 9, 0
    2:
      cards: g '', 9, 9
    3:
      cards: g '', 9, 18
    4:
      cards: g '', 10, 27
  44:
    1:
      cards: g '', 11
    2:
      cards: g '', 11, 12
    3:
      cards: g '', 11, 23
    4:
      cards: g '', 11, 34
  alone:
    1:
      label: '1–9'
      cards: g '', 9
    2:
      label: '10–18'
      cards: ['10', '11', '12', '12-1'].concat(g '', 6, 13)
    3:
      label: '19–27'
      cards: g '', 9, 19
    4:
      label: '28–36'
      cards: ['28', '28-1', '29', '29-1'].concat(g '', 7, 30)
  roses:
    1:
      label: '1–9'
      cards: g '', 9
    2:
      label: '10–18'
      cards: ['10', '11', '12', '13', '13-1'].concat(g '', 5, 14)
    3:
      label: '19–27'
      cards: g '', 9, 19
    4:
      label: '28–36'
      cards: ['28', '28-1', '29', '29-1'].concat(g '', 7, 30)
  reverie:
    1:
      label: '1–10'
      cards: g '', 10
    2:
      label: '11–20'
      cards: ['11', '12', '12-1'].concat(g '', 8, 13)
    3:
      label: '21–30'
      cards: (g '', 8, 21).concat(['28-1', '29', '29-1', '30'])
    4:
      label: '31–40'
      cards: g '', 10, 31
  48:
    1:
      cards: g '', 12
    2:
      cards: g '', 12, 13
    3:
      cards: g '', 12, 25
    4:
      cards: g '', 12, 37
  32:
    1:
      cards: g '', 8
    2:
      cards: g '', 8, 9
    3:
      cards: g '', 8, 17
    4:
      cards: g '', 8, 25
  40:
    1:
      cards: g '', 10
    2:
      cards: g '', 10, 11
    3:
      cards: g '', 10, 21
    4:
      cards: g '', 10, 31
  22:
    1:
      cards: g '', 11, 0
    2:
      cards: g '', 11, 11
  paracelsus:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 22, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
    additional:
      label: '<span style="color:blue;">&equiv;</span>'
      cards: g 'a', 9
  64:
    1:
      cards: g '', 16
    2:
      cards: g '', 16, 17
    3:
      cards: g '', 16, 33
    4:
      cards: g '', 16, 49
  52:
    1:
      cards: g '', 13
    2:
      cards: g '', 13, 14
    3:
      cards: g '', 13, 27
    4:
      cards: g '', 13, 40
  35:
    1:
      cards: g '', 7, 0
    2:
      cards: g '', 7, 7
    3:
      cards: g '', 7, 14
    4:
      cards: g '', 7, 21
    5:
      cards: g '', 7, 28
  520:
    1:
      cards: g '', 13, 0
    2:
      cards: g '', 13, 13
    3:
      cards: g '', 13, 26
    4:
      cards: g '', 13, 39
  50:
    1:
      cards: g '', 10
    2:
      cards: g '', 10, 11
    3:
      cards: g '', 10, 21
    4:
      cards: g '', 10, 31
    5:
      cards: g '', 10, 41
  56:
    1:
      cards: g '', 14
    2:
      cards: g '', 14, 15
    3:
      cards: g '', 14, 29
    4:
      cards: g '', 14, 43
  70:
    1:
      cards: g '', 14
    2:
      cards: g '', 14, 15
    3:
      cards: g '', 14, 29
    4:
      cards: g '', 14, 43
    5:
      cards: g '', 14, 57
  60:
    1:
      cards: g '', 12
    2:
      cards: g '', 12, 13
    3:
      cards: g '', 12, 25
    4:
      cards: g '', 12, 37
  72:
    1:
      cards: g '', 12
    2:
      cards: g '', 12, 13
    3:
      cards: g '', 12, 25
    4:
      cards: g '', 12, 37
    5:
      cards: g '', 12, 49
    6:
      cards: g '', 12, 61
  720:
    1:
      cards: g '', 12, 0
    2:
      cards: g '', 12, 12
    3:
      cards: g '', 12, 24
    4:
      cards: g '', 12, 36
    5:
      cards: g '', 12, 48
    6:
      cards: g '', 12, 60
  90:
    1:
      cards: g '', 18, 0
    2:
      cards: g '', 18, 18
    3:
      cards: g '', 18, 36
    4:
      cards: g '', 18, 54
    5:
      cards: g '', 18, 72
  78:
    1:
      cards: g '', 13
    2:
      cards: g '', 13, 14
    3:
      cards: g '', 13, 27
    4:
      cards: g '', 13, 40
    5:
      cards: g '', 13, 53
    6:
      cards: g '', 13, 66
  81:
    1:
      cards: g '', 27
    2:
      cards: g '', 27, 28
    3:
      cards: g '', 27, 55
  20:
    1:
      cards: g '', 20
  103:
    1:
      cards: g '', 27, 1, 3
    2:
      cards: g '', 27, 28, 3
    3:
      cards: g '', 27, 55, 3
    4:
      cards: g '', 22, 82, 3
  108:
    1:
      cards: g '', 27, 1, 3
    2:
      cards: g '', 27, 28, 3
    3:
      cards: g '', 27, 55, 3
    4:
      cards: g '', 27, 82, 3
  155:
    1:
      cards: g '', 31, 1, 3
    2:
      cards: g '', 31, 32, 3
    3:
      cards: g '', 31, 63, 3
    4:
      cards: g '', 31, 94, 3
    5:
      cards: g '', 31, 125, 3
  roma:
    wands:
      label: '<span style="color:black;">&clubs;</span>'
      cards: g 'w', 13
    cups:
      label: '<span style="color:red;">&hearts;</span>'
      cards: g 'c', 13
    swords:
      label: '<span style="color:black;">&spades;</span>'
      cards: g 's', 13
    discs:
      label: '<span style="color:red;">&diams;</span>'
      cards: g 'p', 13
  healing:
    conspiracy:
      label: 'Conspiracy'
      cards: g '', 45
    healing:
      label: 'Healing'
      cards: g '', 10, 46
    gift:
      label: 'Gift'
      cards: g '', 9, 57
    grace:
      label: 'Grace'
      cards: g '', 24, 67
  cosmic:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g('m', 7, 0).concat(["m06-1", "m06-2"]).concat(g('m', 15, 7)).concat(['back-2'])
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: (g 'w').concat(['back-2'])
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: (g 'c').concat(['back-2'])
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: (g 's').concat(['back-2'])
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: (g 'p').concat(['back-2'])
  futhark:
    1:
      label: 'I'
      cards: g '', 8
    2:
      label: 'II'
      cards: g '', 8, 9
    3:
      label: 'III'
      cards: g '', 8, 17
  'futhark+':
    1:
      label: 'I'
      cards: g '', 8
    2:
      label: 'II'
      cards: g '', 8, 9
    3:
      label: 'III'
      cards: g '', 9, 17
  futhork:
    1:
      label: 'I'
      cards: g '', 8
    2:
      label: 'II'
      cards: g '', 8, 9
    3:
      label: 'III'
      cards: g '', 8, 17
    4:
      label: 'IV'
      cards: g '', 9, 25
  stardust:
    1:
      cards: g '', 20, 0
    2:
      cards: g '', 20, 20
    3:
      cards: g '', 20, 40
    4:
      cards: g '', 20, 60
    5:
      cards: (g '', 20, 80).concat([100, 101, 102])
  daniloff:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g('m', 9, 0).concat(["m08-1", "m09", "m10", "m11", "m11-1"]).concat(g('m', 10, 12)).concat(['white'])
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  maroon:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 23, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  akron:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 24, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  shapeshifter:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 25, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  sangre:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g('m', 12, 0).concat(["m11-2"]).concat(g('m', 13, 12))
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  clover:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g('m', 7, 0).concat(["m06-1"]).concat(g('m', 15, 7))
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: (g 'w')
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: (g 'c')
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: (g 's')
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: (g 'p')
  alice:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g('m', 7, 0).concat(["m06-1"]).concat(g('m', 15, 7))
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: (g 'w', 7, 1).concat(["w07-1"]).concat(g('w', 7, 8))
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: (g 'c')
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: (g 's')
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: (g 'p')
  chairs:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 24, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  soulbreath:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: ["m00", "m01", "m01-1", "m02", "m03", "m03-1", "m04", "m05", "m06", "m07", "m08", "m09", "m10", "m11", "m11-1", "m12", "m13", "m14", "m15", "m15-1", "m16", "m17", "m18", "m19", "m20", "m21"]
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  neworlean:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: ['m00-1'].concat(g 'm', 22, 0)
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
  psychic:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 22, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w', 9
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c', 9
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's', 9
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p', 9
    chakras:
      label: 'Chakras'
      cards: g 'x', 7
  80:
    all:
      label: 'Σ'
      cards: g '', 80
  wild:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g 'm', 22, 0
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g 'w'
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g 'c'
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g 's'
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g 'p'
    alternatives:
      label: '≈'
      cards: g 'z',	6
  viceverse:
    major:
      label: 'Major'
      icon: '/major.png'
      cards: g('m', 22, 0).concat(g('mb', 22, 0))
    wands:
      label: 'Wands'
      icon: '/wands.png'
      cards: g('w').concat(g('wb'))
    cups:
      label: 'Cups'
      icon: '/cups.png'
      cards: g('c').concat(g('cb'))
    swords:
      label: 'Swords'
      icon: '/swords.png'
      cards: g('s').concat(g('sb'))
    discs:
      label: 'Disks'
      icon: '/discs.png'
      cards: g('p').concat(g('pb'))
  warlock:
    major:
      label: 'Старшие'
      cards: g('m', 22, 0)
    angel:
      label: 'Дом Ангелов'
      cards: g('angel', 7)
    body:
      label: 'Дом Тела'
      cards: g('body', 7)
    demon:
      label: 'Дом Демонов'
      cards: g('demon', 7)
    planet:
      label: 'Дом Планет'
      cards: g('planet', 7)
    sin:
      label: 'Дом Грехов'
      cards: g('sin', 7)
