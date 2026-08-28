extends TileModifierSpell

func set_status_tooltips():
	status_tooltips = [TileStatus.MYSTERY, TileStatus.FROZEN]

func get_tooltip_context():
	return {}

const FIXED_OPTIONS_CAP := 4

const POOF_COLOR := Color("#009aff")

var start_end_parity := 0

func get_save_data():
	var save = super.get_save_data()
	save["start_end_parity"] = start_end_parity
	return save


func load_save_data(save):
	super.load_save_data(save)
	start_end_parity = save.start_end_parity

const SHORT_WORD_BIGRAMS := {
	OVERALL={
		"ws": 0.102, "dg": 0.102, "eb": 0.104, "ah": 0.104, "yo": 0.106,
		"oe": 0.106, "jo": 0.108, "sm": 0.108, "rl": 0.111, "ka": 0.111, "hy": 0.113,
		"ua": 0.115, "oy": 0.115, "of": 0.115, "ft": 0.117, "wn": 0.117, "ph": 0.119,
		"ci": 0.119, "dl": 0.119, "mm": 0.119, "ys": 0.121, "az": 0.124, "py": 0.124,
		"ja": 0.124, "io": 0.126, "ct": 0.126, "sn": 0.128, "nu": 0.130, "wh": 0.130,
		"rg": 0.132, "ef": 0.132, "ei": 0.132, "af": 0.134, "bs": 0.137, "fu": 0.139,
		"vo": 0.139, "sw": 0.139, "eg": 0.141, "if": 0.141, "sy": 0.143, "bb": 0.143,
		"ev": 0.145, "dd": 0.145, "fr": 0.150, "wo": 0.152, "ny": 0.152, "gh": 0.152,
		"gg": 0.152, "dy": 0.154, "ld": 0.154, "ui": 0.154, "ky": 0.156, "ov": 0.158,
		"ub": 0.165, "iv": 0.165, "ex": 0.165, "mb": 0.167, "rk": 0.169, "ze": 0.169,
		"rm": 0.171, "ew": 0.173, "gs": 0.176, "va": 0.176, "ud": 0.176, "ye": 0.176,
		"pp": 0.178, "sk": 0.180, "ms": 0.180, "mu": 0.182, "rr": 0.184, "au": 0.184,
		"og": 0.184, "dr": 0.184, "ug": 0.184, "oi": 0.186, "gi": 0.189, "rn": 0.189,
		"uc": 0.193, "gu": 0.193, "ia": 0.195, "nn": 0.195, "gl": 0.197, "du": 0.202,
		"rd": 0.204, "ep": 0.206, "lt": 0.206, "qu": 0.206, "fo": 0.208, "pl": 0.217,
		"ok": 0.217, "oc": 0.219, "ue": 0.219, "ff": 0.219, "nc": 0.221, "ob": 0.221,
		"aw": 0.221, "sl": 0.230, "sc": 0.232, "ec": 0.236, "pu": 0.238, "ey": 0.241,
		"up": 0.241, "pr": 0.243, "cu": 0.243, "su": 0.243, "cl": 0.243, "tu": 0.245,
		"tt": 0.249, "hu": 0.249, "av": 0.251, "ki": 0.254, "fa": 0.254, "vi": 0.254,
		"ip": 0.256, "oa": 0.256, "fi": 0.260, "em": 0.260, "fe": 0.262, "fl": 0.267,
		"ry": 0.269, "bi": 0.277, "br": 0.284, "ss": 0.286, "ty": 0.288, "gr": 0.288,
		"ab": 0.290, "ak": 0.293, "go": 0.293, "ay": 0.295, "ig": 0.295, "da": 0.297,
		"so": 0.297, "im": 0.299, "ul": 0.299, "od": 0.306, "si": 0.306, "rt": 0.316,
		"lu": 0.319, "mp": 0.321, "wi": 0.323, "om": 0.323, "nk": 0.323, "cr": 0.329,
		"ga": 0.332, "bl": 0.332, "ps": 0.334, "bu": 0.336, "ni": 0.340, "sp": 0.340,
		"we": 0.345, "ag": 0.345, "op": 0.351, "ds": 0.351, "no": 0.360, "ks": 0.364,
		"sa": 0.368, "ls": 0.371, "ap": 0.371, "na": 0.375, "hi": 0.375, "ru": 0.375,
		"ut": 0.386, "um": 0.392, "wa": 0.394, "ir": 0.401, "ly": 0.412, "pi": 0.414,
		"tr": 0.414, "mi": 0.418, "th": 0.418, "po": 0.418, "di": 0.425, "do": 0.425,
		"os": 0.425, "nd": 0.427, "ow": 0.429, "id": 0.436, "ns": 0.442, "ti": 0.442,
		"ol": 0.449, "ot": 0.460, "ba": 0.462, "ad": 0.464, "ce": 0.464, "ai": 0.464,
		"be": 0.473, "ou": 0.486, "mo": 0.494, "rs": 0.496, "nt": 0.496, "ac": 0.505,
		"ie": 0.505, "bo": 0.505, "pa": 0.514, "us": 0.525, "et": 0.540, "is": 0.544,
		"to": 0.548, "ic": 0.551, "ur": 0.564, "am": 0.564, "ca": 0.574, "ck": 0.574,
		"ll": 0.583, "he": 0.590, "it": 0.600, "ha": 0.600, "ho": 0.607, "sh": 0.611,
		"ee": 0.613, "un": 0.620, "me": 0.629, "co": 0.633, "ge": 0.633, "ta": 0.637,
		"li": 0.642, "il": 0.642, "ve": 0.661, "ma": 0.670, "ts": 0.672, "as": 0.707,
		"ch": 0.707, "ke": 0.709, "oo": 0.711, "at": 0.717, "pe": 0.733, "el": 0.739,
		"lo": 0.756, "ne": 0.763, "la": 0.813, "ro": 0.819, "ea": 0.824, "ng": 0.834,
		"ri": 0.841, "se": 0.856, "on": 0.865, "de": 0.891, "en": 0.921, "or": 0.945,
		"st": 0.997, "al": 0.997, "te": 1.084, "ra": 1.090, "an": 1.127, "ar": 1.296,
		"re": 1.337, "le": 1.350, "es": 1.584, "in": 1.639, "ed": 1.868, "er": 2.100,
	},
	START={
	"yu": 0.106, "on": 0.106, "ed": 0.106,
	"us": 0.106, "ic": 0.115, "ko": 0.115, "ow": 0.115, "hy": 0.115, "od": 0.115,
	"ty": 0.124, "av": 0.124, "zi": 0.124, "ze": 0.132, "af": 0.132, "id": 0.132,
	"ev": 0.132, "at": 0.141, "im": 0.141, "au": 0.150, "sq": 0.150, "ag": 0.159,
	"op": 0.177, "ap": 0.185, "ph": 0.185, "aw": 0.194, "wr": 0.194, "ji": 0.203,
	"ce": 0.203, "kn": 0.203, "ya": 0.212, "ou": 0.212, "ai": 0.221, "up": 0.221,
	"yo": 0.221, "ka": 0.221, "el": 0.221, "je": 0.229, "nu": 0.238, "em": 0.238,
	"ci": 0.238, "ye": 0.238, "or": 0.247, "er": 0.247, "tw": 0.265, "ea": 0.265,
	"ab": 0.274, "ke": 0.274, "as": 0.282, "vo": 0.282, "ad": 0.282, "sm": 0.309,
	"ju": 0.327, "ac": 0.335, "sk": 0.335, "am": 0.344, "jo": 0.353, "en": 0.353,
	"gi": 0.362, "ex": 0.362, "ni": 0.380, "fu": 0.380, "ja": 0.397, "gl": 0.406,
	"va": 0.406, "ge": 0.424, "lu": 0.424, "an": 0.459, "ne": 0.468, "ve": 0.477,
	"wo": 0.485, "na": 0.494, "vi": 0.503, "qu": 0.503, "hi": 0.512, "we": 0.512,
	"pl": 0.512, "ki": 0.512, "wh": 0.521, "gu": 0.521, "sn": 0.521, "ar": 0.538,
	"tu": 0.556, "mu": 0.565, "no": 0.565, "sw": 0.565, "ru": 0.574, "in": 0.591,
	"fe": 0.591, "fr": 0.591, "un": 0.600, "th": 0.618, "al": 0.627, "du": 0.635,
	"hu": 0.644, "dr": 0.644, "bi": 0.662, "cu": 0.680, "te": 0.697, "bl": 0.733,
	"sc": 0.733, "su": 0.733, "ri": 0.733, "da": 0.741, "go": 0.750, "fo": 0.768,
	"pu": 0.777, "ti": 0.777, "si": 0.786, "le": 0.803, "pr": 0.821, "fi": 0.821,
	"wi": 0.830, "sl": 0.830, "he": 0.883, "ga": 0.891, "cl": 0.900, "fa": 0.900,
	"me": 0.918, "pi": 0.953, "li": 0.962, "so": 0.962, "fl": 0.962, "mi": 0.971,
	"ro": 0.971, "di": 0.971, "tr": 0.980, "br": 0.997, "pe": 1.006, "wa": 1.015,
	"to": 1.015, "se": 1.033, "do": 1.068, "gr": 1.086, "cr": 1.086, "lo": 1.121,
	"sa": 1.121, "po": 1.121, "ha": 1.165, "bu": 1.174, "sp": 1.183, "la": 1.183,
	"be": 1.200, "ta": 1.244, "ch": 1.262, "ho": 1.306, "ra": 1.333, "sh": 1.333,
	"de": 1.342, "mo": 1.386, "pa": 1.509, "bo": 1.536, "ba": 1.536, "ma": 1.633,
	"ca": 1.668, "st": 1.677, "re": 1.809, "co": 1.889,
},
END = {
	"ca": 0.106, "ph": 0.106,
	"oe": 0.106, "pa": 0.106, "tz": 0.106, "lf": 0.115, "ka": 0.115, "wl": 0.124,
	"ek": 0.124, "ud": 0.124, "mo": 0.124, "bo": 0.124, "ba": 0.124, "co": 0.124,
	"ea": 0.133, "ga": 0.133, "va": 0.133, "ax": 0.133, "ho": 0.133, "vy": 0.133,
	"ok": 0.133, "da": 0.142, "un": 0.151, "he": 0.151, "be": 0.151, "cy": 0.151,
	"gh": 0.151, "ub": 0.151, "ob": 0.151, "ig": 0.159, "sk": 0.168, "rm": 0.168,
	"ul": 0.168, "ug": 0.177, "ol": 0.177, "em": 0.177, "ex": 0.177, "im": 0.177,
	"go": 0.186, "og": 0.186, "ht": 0.186, "fy": 0.186, "zy": 0.186, "ep": 0.186,
	"ha": 0.186, "pt": 0.186, "ak": 0.186, "aw": 0.195, "ld": 0.204, "ab": 0.204,
	"lo": 0.213, "la": 0.221, "oy": 0.221, "fs": 0.230, "no": 0.230, "od": 0.230,
	"ia": 0.230, "ze": 0.239, "wn": 0.239, "ew": 0.239, "ft": 0.239, "oo": 0.239,
	"ah": 0.248, "ip": 0.248, "ct": 0.248, "ag": 0.248, "ir": 0.248, "cs": 0.257,
	"gy": 0.257, "ro": 0.275, "do": 0.275, "hy": 0.283, "to": 0.283, "hs": 0.283,
	"rk": 0.283, "om": 0.292, "by": 0.301, "my": 0.310, "ap": 0.319, "rn": 0.319,
	"pe": 0.328, "ta": 0.328, "ur": 0.337, "rd": 0.345, "lt": 0.354, "op": 0.354,
	"ma": 0.381, "ut": 0.390, "ff": 0.390, "na": 0.399, "ra": 0.399, "ue": 0.399,
	"um": 0.399, "ws": 0.399, "ad": 0.399, "mp": 0.407, "ee": 0.416, "ys": 0.416,
	"up": 0.434, "me": 0.434, "py": 0.434, "ow": 0.443, "am": 0.443, "is": 0.443,
	"il": 0.461, "sy": 0.469, "ss": 0.469, "nd": 0.478, "ke": 0.478, "ny": 0.505,
	"th": 0.505, "bs": 0.514, "rt": 0.523, "ay": 0.523, "ot": 0.523, "at": 0.531,
	"as": 0.540, "nk": 0.549, "dy": 0.558, "de": 0.585, "ve": 0.585, "ll": 0.585,
	"id": 0.593, "os": 0.629, "us": 0.629, "ky": 0.638, "ic": 0.647, "it": 0.673,
	"gs": 0.691, "sh": 0.700, "ar": 0.700, "ms": 0.700, "ce": 0.709, "ie": 0.753,
	"ck": 0.762, "or": 0.771, "ey": 0.779, "an": 0.797, "ge": 0.815, "el": 0.850,
	"se": 0.850, "ne": 0.850, "nt": 0.877, "in": 0.903, "ry": 0.957, "te": 0.974,
	"ty": 1.001, "re": 1.019, "st": 1.045, "ch": 1.054, "et": 1.063, "en": 1.134,
	"ps": 1.187, "al": 1.231, "on": 1.258, "ds": 1.408, "ls": 1.417, "ns": 1.452,
	"ks": 1.479, "ly": 1.550, "rs": 1.630, "le": 2.090, "ng": 2.179, "ts": 2.639,
	"es": 5.128, "er": 5.606, "ed": 6.722,
}

}

const SHORT_WORD_TRIGRAMS := {
	END={
	"rky": 0.103, "oof": 0.103, "try": 0.103, "ign": 0.103,
	"ret": 0.103, "mbs": 0.103, "fty": 0.103, "ind": 0.103, "iny": 0.103, "bit": 0.103,
	"llo": 0.103, "oom": 0.103, "ium": 0.103, "oat": 0.103, "ere": 0.103, "uch": 0.103,
	"uds": 0.103, "awn": 0.103, "oys": 0.103, "thy": 0.103, "een": 0.103, "ily": 0.103,
	"oth": 0.103, "ual": 0.103, "ama": 0.103, "eck": 0.103, "nto": 0.103, "air": 0.103,
	"nal": 0.103, "osh": 0.103, "ase": 0.103, "mon": 0.103, "tar": 0.103, "und": 0.103,
	"ogs": 0.103, "ike": 0.103, "all": 0.103, "sks": 0.103, "rty": 0.103, "fed": 0.103,
	"xes": 0.115, "ffy": 0.115, "ney": 0.115, "mpy": 0.115, "xed": 0.115, "ree": 0.115,
	"lin": 0.115, "rth": 0.115, "chy": 0.115, "och": 0.115, "uce": 0.115, "aws": 0.115,
	"ful": 0.115, "way": 0.115, "ift": 0.115, "imp": 0.115, "shy": 0.115, "ipe": 0.115,
	"oms": 0.115, "ime": 0.115, "ews": 0.115, "che": 0.115, "ape": 0.115, "ugs": 0.115,
	"ugh": 0.115, "ngo": 0.115, "aid": 0.115, "ana": 0.115, "oks": 0.115, "ull": 0.115,
	"nty": 0.115, "lot": 0.115, "lon": 0.115, "old": 0.115, "rer": 0.126, "rch": 0.126,
	"eek": 0.126, "oss": 0.126, "nna": 0.126, "ong": 0.126, "sel": 0.126, "ory": 0.126,
	"obs": 0.126, "die": 0.126, "ear": 0.126, "kup": 0.126, "lar": 0.126, "ole": 0.126,
	"ubs": 0.126, "ras": 0.126, "mit": 0.126, "que": 0.126, "ace": 0.126, "set": 0.126,
	"ote": 0.126, "gie": 0.126, "ndy": 0.126, "ord": 0.126, "ead": 0.126, "ope": 0.126,
	"gue": 0.126, "fts": 0.126, "oll": 0.126, "ina": 0.126, "rse": 0.126, "and": 0.137,
	"amp": 0.137, "abs": 0.137, "ark": 0.137, "oes": 0.137, "son": 0.137, "ell": 0.137,
	"vel": 0.137, "ode": 0.137, "ums": 0.137, "tly": 0.137, "rge": 0.137, "urs": 0.137,
	"ect": 0.137, "ilt": 0.137, "ues": 0.137, "ath": 0.137, "ino": 0.137, "lds": 0.149,
	"iff": 0.149, "kle": 0.149, "eep": 0.149, "aze": 0.149, "eps": 0.149, "orn": 0.149,
	"men": 0.149, "ags": 0.149, "ony": 0.149, "irs": 0.149, "art": 0.149, "ffs": 0.149,
	"ook": 0.149, "low": 0.149, "row": 0.160, "ray": 0.160, "nic": 0.160, "ora": 0.160,
	"oot": 0.160, "eat": 0.160, "eer": 0.160, "ods": 0.160, "ast": 0.160, "ame": 0.160,
	"eak": 0.160, "ach": 0.160, "bes": 0.160, "den": 0.160, "wns": 0.160, "bed": 0.160,
	"ven": 0.160, "eed": 0.172, "ral": 0.172, "rns": 0.172, "tal": 0.172, "ees": 0.172,
	"key": 0.172, "lts": 0.172, "ert": 0.172, "ier": 0.172, "ggy": 0.172, "ddy": 0.172,
	"uck": 0.172, "yer": 0.172, "ust": 0.172, "unt": 0.172, "rly": 0.172, "ove": 0.172,
	"oon": 0.172, "oop": 0.172, "zed": 0.172, "ute": 0.172, "rms": 0.172, "aks": 0.172,
	"ten": 0.172, "oke": 0.183, "ose": 0.183, "wer": 0.183, "ple": 0.183, "ive": 0.183,
	"yed": 0.183, "ush": 0.183, "ics": 0.183, "own": 0.183, "tic": 0.183, "cer": 0.183,
	"ley": 0.183, "cky": 0.183, "uts": 0.195, "ion": 0.195, "ung": 0.195, "ery": 0.195,
	"rks": 0.195, "end": 0.195, "ess": 0.195, "hed": 0.195, "ial": 0.195, "ken": 0.195,
	"ock": 0.195, "ort": 0.195, "ity": 0.195, "ump": 0.195, "ade": 0.206, "eal": 0.206,
	"ssy": 0.206, "ton": 0.206, "ang": 0.206, "ile": 0.206, "are": 0.206, "ick": 0.206,
	"unk": 0.206, "uff": 0.206, "eds": 0.206, "nge": 0.206, "ket": 0.206, "ane": 0.218,
	"ths": 0.218, "tle": 0.218, "hes": 0.218, "sty": 0.218, "ave": 0.218, "ise": 0.218,
	"ink": 0.218, "rds": 0.218, "mmy": 0.218, "ary": 0.218, "ure": 0.218, "ght": 0.218,
	"dly": 0.218, "fer": 0.218, "ide": 0.218, "ber": 0.218, "ams": 0.218, "ish": 0.229,
	"ids": 0.229, "ant": 0.229, "ank": 0.229, "pes": 0.229, "ake": 0.229, "ard": 0.229,
	"nky": 0.240, "ops": 0.240, "dge": 0.240, "int": 0.240, "ite": 0.252, "one": 0.252,
	"ved": 0.252, "ail": 0.252, "nny": 0.252, "bby": 0.252, "ser": 0.252, "ire": 0.252,
	"ied": 0.252, "tty": 0.263, "her": 0.263, "aps": 0.263, "out": 0.263, "ced": 0.263,
	"ain": 0.263, "ale": 0.263, "ens": 0.263, "tor": 0.263, "ges": 0.263, "man": 0.263,
	"mes": 0.263, "mer": 0.275, "ore": 0.275, "ice": 0.275, "ppy": 0.275, "our": 0.275,
	"ill": 0.275, "ads": 0.275, "ips": 0.275, "rts": 0.275, "ors": 0.275, "nce": 0.286,
	"ash": 0.286, "ils": 0.286, "ows": 0.286, "ays": 0.286, "gle": 0.286, "rry": 0.298,
	"use": 0.298, "ist": 0.298, "ely": 0.309, "ots": 0.309, "let": 0.309, "age": 0.309,
	"ack": 0.309, "des": 0.321, "nch": 0.321, "ces": 0.332, "els": 0.344, "tch": 0.344,
	"mps": 0.344, "dle": 0.355, "ets": 0.355, "ngs": 0.355, "wed": 0.355, "ver": 0.366,
	"ons": 0.366, "ans": 0.366, "als": 0.366, "nes": 0.389, "tes": 0.401, "ins": 0.401,
	"nts": 0.401, "ler": 0.401, "ine": 0.412, "nks": 0.412, "med": 0.412, "its": 0.424,
	"sts": 0.424, "kes": 0.435, "nds": 0.447, "ner": 0.447, "ars": 0.458, "ats": 0.458,
	"ent": 0.458, "ate": 0.470, "sed": 0.481, "lly": 0.492, "ded": 0.492, "est": 0.492,
	"ger": 0.515, "ble": 0.515, "ies": 0.527, "ves": 0.538, "red": 0.538, "ged": 0.550,
	"lls": 0.550, "per": 0.561, "ned": 0.561, "res": 0.573, "les": 0.607, "ped": 0.641,
	"ker": 0.653, "ses": 0.664, "cks": 0.733, "led": 0.744, "der": 0.802, "ked": 0.882,
	"ted": 0.996, "ers": 1.065, "ter": 1.111, "ing": 2.279,
},
	START={
	"sig": 0.102, "leg": 0.102,
	"bol": 0.102, "int": 0.102, "doo": 0.102, "bit": 0.102, "ris": 0.102, "lun": 0.102,
	"nic": 0.102, "red": 0.102, "son": 0.102, "rav": 0.102, "ple": 0.102, "bag": 0.102,
	"ass": 0.102, "act": 0.102, "smi": 0.102, "twe": 0.102, "wai": 0.102, "tim": 0.102,
	"hot": 0.102, "hur": 0.102, "inf": 0.102, "gui": 0.102, "gau": 0.102, "thu": 0.102,
	"fac": 0.102, "bog": 0.102, "spu": 0.102, "fel": 0.102, "duc": 0.102, "liv": 0.102,
	"soa": 0.102, "sni": 0.102, "kno": 0.102, "fol": 0.102, "deb": 0.102, "pie": 0.102,
	"bab": 0.102, "pul": 0.102, "who": 0.102, "exp": 0.102, "tit": 0.102, "til": 0.102,
	"rin": 0.102, "rig": 0.102, "tam": 0.102, "tap": 0.102, "tip": 0.102, "rub": 0.102,
	"hin": 0.102, "wag": 0.102, "was": 0.102, "ala": 0.102, "tow": 0.102, "cos": 0.102,
	"top": 0.102, "dol": 0.102, "dor": 0.102, "god": 0.102, "goa": 0.102, "gul": 0.113,
	"bor": 0.113, "pai": 0.113, "pet": 0.113, "bru": 0.113, "mut": 0.113, "bul": 0.113,
	"mal": 0.113, "vis": 0.113, "gam": 0.113, "fun": 0.113, "dam": 0.113, "bum": 0.113,
	"pop": 0.113, "ami": 0.113, "rus": 0.113, "dep": 0.113, "arm": 0.113, "smo": 0.113,
	"reb": 0.113, "reg": 0.113, "tac": 0.113, "rum": 0.113, "tom": 0.113, "ven": 0.113,
	"rid": 0.113, "sou": 0.113, "sir": 0.113, "sub": 0.113, "kid": 0.113, "but": 0.113,
	"bos": 0.113, "lap": 0.113, "mag": 0.113, "fat": 0.113, "mel": 0.113, "plo": 0.113,
	"pen": 0.124, "beg": 0.124, "cab": 0.124, "run": 0.124, "dev": 0.124, "lam": 0.124,
	"men": 0.124, "rap": 0.124, "que": 0.124, "gal": 0.124, "rou": 0.124, "imp": 0.124,
	"ram": 0.124, "fir": 0.124, "tas": 0.124, "lac": 0.124, "div": 0.124, "cle": 0.124,
	"san": 0.124, "whe": 0.124, "lar": 0.124, "dan": 0.124, "sil": 0.124, "ang": 0.124,
	"pic": 0.124, "ali": 0.124, "dre": 0.124, "ear": 0.124, "ren": 0.124, "sun": 0.124,
	"gla": 0.124, "rag": 0.124, "dar": 0.124, "gre": 0.124, "gru": 0.124, "val": 0.124,
	"bou": 0.124, "hat": 0.124, "may": 0.124, "thi": 0.124, "lou": 0.124, "mad": 0.124,
	"yea": 0.124, "uni": 0.124, "fai": 0.124, "dum": 0.124, "mot": 0.136, "dee": 0.136,
	"ber": 0.136, "roa": 0.136, "hom": 0.136, "roo": 0.136, "lan": 0.136, "pra": 0.136,
	"rai": 0.136, "pho": 0.136, "wha": 0.136, "fre": 0.136, "cap": 0.136, "kin": 0.136,
	"pun": 0.136, "gar": 0.136, "wan": 0.136, "rot": 0.136, "mai": 0.136, "cop": 0.136,
	"rob": 0.136, "all": 0.136, "sur": 0.136, "awa": 0.136, "tun": 0.136, "mod": 0.136,
	"sle": 0.147, "cou": 0.147, "ref": 0.147, "don": 0.147, "ver": 0.147, "rep": 0.147,
	"blu": 0.147, "rem": 0.147, "hal": 0.147, "hel": 0.147, "met": 0.147, "hor": 0.147,
	"wee": 0.147, "far": 0.147, "woo": 0.147, "def": 0.147, "loa": 0.147, "ben": 0.147,
	"cam": 0.147, "mea": 0.147, "sav": 0.147, "plu": 0.147, "por": 0.147, "las": 0.147,
	"pil": 0.147, "spr": 0.147, "bli": 0.147, "ble": 0.147, "clu": 0.147, "del": 0.147,
	"tur": 0.158, "ton": 0.158, "sin": 0.158, "ser": 0.158, "med": 0.158, "mas": 0.158,
	"res": 0.158, "ree": 0.158, "cut": 0.158, "rat": 0.158, "cal": 0.158, "lim": 0.158,
	"mus": 0.158, "hol": 0.158, "pac": 0.158, "hun": 0.158, "rac": 0.158, "rel": 0.158,
	"dro": 0.158, "pos": 0.158, "wal": 0.158, "slu": 0.158, "the": 0.158, "rev": 0.158,
	"tor": 0.158, "tre": 0.170, "bow": 0.170, "han": 0.170, "pas": 0.170, "bun": 0.170,
	"tal": 0.170, "tro": 0.170, "lat": 0.170, "moo": 0.170, "bee": 0.170, "dri": 0.170,
	"wea": 0.170, "mon": 0.170, "shr": 0.170, "twi": 0.170, "den": 0.170, "swe": 0.170,
	"sea": 0.170, "dec": 0.170, "tin": 0.170, "dea": 0.170, "wil": 0.181, "hon": 0.181,
	"flu": 0.181, "sor": 0.181, "cru": 0.181, "goo": 0.181, "out": 0.181, "fri": 0.181,
	"scr": 0.181, "fra": 0.181, "pal": 0.181, "loc": 0.181, "bat": 0.181, "poo": 0.181,
	"mol": 0.181, "see": 0.181, "pre": 0.181, "fle": 0.181, "mis": 0.181, "sen": 0.181,
	"sol": 0.181, "tar": 0.181, "mat": 0.181, "mou": 0.181, "fin": 0.181, "squ": 0.192,
	"bal": 0.192, "pea": 0.192, "pat": 0.192, "ten": 0.192, "col": 0.192, "fro": 0.192,
	"hum": 0.192, "fli": 0.192, "glo": 0.192, "swi": 0.192, "tea": 0.192, "bus": 0.192,
	"tru": 0.192, "rec": 0.204, "mer": 0.204, "fil": 0.204, "slo": 0.204, "dis": 0.204,
	"tan": 0.204, "pol": 0.204, "rea": 0.204, "ran": 0.204, "pur": 0.204, "bre": 0.204,
	"bel": 0.204, "chu": 0.215, "coo": 0.215, "per": 0.215, "flo": 0.215, "sna": 0.215,
	"gen": 0.215, "mil": 0.215, "spe": 0.215, "qui": 0.215, "pee": 0.226, "win": 0.226,
	"wor": 0.226, "cas": 0.226, "cli": 0.226, "cri": 0.226, "bla": 0.226, "thr": 0.226,
	"qua": 0.226, "sti": 0.226, "cro": 0.238, "bas": 0.238, "sno": 0.238, "loo": 0.238,
	"dra": 0.249, "she": 0.249, "shi": 0.249, "bro": 0.249, "swa": 0.249, "stu": 0.249,
	"din": 0.249, "her": 0.249, "pla": 0.249, "ski": 0.249, "sli": 0.249, "bon": 0.249,
	"hea": 0.260, "pan": 0.260, "lin": 0.260, "ste": 0.260, "sal": 0.260, "spo": 0.271,
	"har": 0.271, "blo": 0.271, "pin": 0.283, "ban": 0.283, "par": 0.283, "gri": 0.283,
	"mor": 0.283, "whi": 0.283, "min": 0.283, "sca": 0.283, "sco": 0.283, "spa": 0.294,
	"war": 0.294, "com": 0.294, "cho": 0.294, "cor": 0.294, "bri": 0.294, "sla": 0.294,
	"cre": 0.294, "cur": 0.294, "bea": 0.305, "clo": 0.305, "con": 0.305, "pro": 0.305,
	"che": 0.317, "hoo": 0.317, "bur": 0.317, "gro": 0.317, "man": 0.328, "lea": 0.339,
	"tri": 0.339, "mar": 0.339, "sho": 0.339, "tra": 0.351, "spi": 0.351, "cla": 0.351,
	"can": 0.362, "for": 0.362, "pri": 0.373, "chi": 0.385, "sto": 0.385, "str": 0.385,
	"bar": 0.396, "boo": 0.396, "cha": 0.396, "bra": 0.407, "fla": 0.419, "cra": 0.430,
	"car": 0.441, "gra": 0.543, "sha": 0.577, "sta": 0.600,
	},
	OVERALL={
	"mel": 0.100, "pos": 0.100,
	"ied": 0.100, "ilt": 0.100, "oom": 0.100, "ids": 0.100, "sty": 0.100, "mil": 0.100,
	"swa": 0.100, "abb": 0.100, "iff": 0.100, "rro": 0.100, "wea": 0.100, "roa": 0.100,
	"wan": 0.100, "ial": 0.100, "gar": 0.100, "bby": 0.100, "son": 0.100, "nny": 0.100,
	"bas": 0.100, "arl": 0.100, "cas": 0.100, "ean": 0.100, "ool": 0.100, "pea": 0.100,
	"cer": 0.100, "pal": 0.100, "mas": 0.100, "ops": 0.100, "ani": 0.100, "dis": 0.100,
	"ved": 0.100, "pac": 0.100, "cri": 0.105, "loc": 0.105, "oil": 0.105, "mou": 0.105,
	"pur": 0.105, "act": 0.105, "rot": 0.105, "tty": 0.105, "ken": 0.105, "tea": 0.105,
	"nor": 0.105, "bro": 0.105, "sli": 0.105, "lim": 0.105, "poo": 0.105, "loa": 0.105,
	"stu": 0.105, "unc": 0.105, "rne": 0.105, "ski": 0.105, "ral": 0.109, "ier": 0.109,
	"die": 0.109, "ipe": 0.109, "lot": 0.109, "umb": 0.109, "bre": 0.109, "shi": 0.109,
	"spe": 0.109, "arn": 0.109, "ppy": 0.109, "rip": 0.109, "rav": 0.109, "bal": 0.109,
	"fin": 0.109, "ion": 0.109, "lum": 0.109, "ads": 0.109, "bel": 0.109, "lou": 0.109,
	"eck": 0.114, "oss": 0.114, "ott": 0.114, "ama": 0.114, "ips": 0.114, "blo": 0.114,
	"ays": 0.114, "nic": 0.114, "gri": 0.114, "dra": 0.114, "ges": 0.114, "lac": 0.114,
	"rel": 0.114, "wor": 0.114, "oun": 0.114, "hes": 0.114, "sen": 0.114, "hee": 0.114,
	"sti": 0.114, "eek": 0.114, "bus": 0.114, "eer": 0.114, "nte": 0.114, "spo": 0.114,
	"wee": 0.114, "fle": 0.114, "urs": 0.118, "rts": 0.118, "hal": 0.118, "lee": 0.118,
	"mon": 0.118, "iss": 0.118, "mit": 0.118, "rry": 0.118, "que": 0.118, "ath": 0.118,
	"ike": 0.118, "tre": 0.118, "aps": 0.118, "lay": 0.118, "ray": 0.118, "ala": 0.118,
	"rse": 0.118, "por": 0.118, "whi": 0.118, "spa": 0.118, "wer": 0.118, "ond": 0.118,
	"tru": 0.118, "ils": 0.118, "ere": 0.123, "bon": 0.123, "ced": 0.123, "ows": 0.123,
	"tle": 0.123, "hum": 0.123, "ots": 0.123, "pla": 0.123, "rid": 0.123, "clo": 0.123,
	"ord": 0.123, "alt": 0.123, "cro": 0.123, "rum": 0.123, "pes": 0.123, "ely": 0.123,
	"coo": 0.123, "rus": 0.123, "hon": 0.123, "llo": 0.123, "pen": 0.123, "sla": 0.123,
	"ipp": 0.123, "bea": 0.127, "fer": 0.127, "gen": 0.127, "ess": 0.127, "ime": 0.127,
	"ban": 0.127, "anc": 0.127, "pee": 0.127, "ost": 0.127, "rou": 0.127, "han": 0.127,
	"sca": 0.132, "ann": 0.132, "gro": 0.132, "ple": 0.132, "ous": 0.132, "eve": 0.132,
	"tic": 0.132, "men": 0.132, "sin": 0.132, "ead": 0.132, "com": 0.132, "aze": 0.132,
	"ode": 0.132, "ach": 0.132, "tro": 0.136, "arr": 0.136, "rit": 0.136, "den": 0.136,
	"cal": 0.136, "lie": 0.136, "mes": 0.136, "qua": 0.136, "bur": 0.136, "ood": 0.136,
	"bri": 0.136, "ric": 0.136, "pan": 0.136, "orn": 0.136, "lat": 0.136, "lic": 0.136,
	"mps": 0.136, "oin": 0.136, "ren": 0.136, "imp": 0.136, "ong": 0.141, "gge": 0.141,
	"qui": 0.141, "ute": 0.141, "run": 0.141, "und": 0.141, "ras": 0.141, "ets": 0.141,
	"ish": 0.141, "ote": 0.141, "ome": 0.141, "ram": 0.141, "ron": 0.145, "ark": 0.145,
	"ole": 0.145, "sal": 0.145, "cla": 0.145, "hor": 0.145, "cur": 0.145, "let": 0.145,
	"els": 0.145, "ngs": 0.145, "spi": 0.145, "rge": 0.145, "oop": 0.150, "ari": 0.150,
	"tan": 0.150, "own": 0.150, "rac": 0.150, "las": 0.150, "pro": 0.150, "oot": 0.150,
	"ght": 0.150, "ung": 0.150, "sho": 0.150, "old": 0.150, "sco": 0.155, "rap": 0.155,
	"din": 0.155, "lon": 0.155, "kin": 0.155, "lam": 0.155, "rie": 0.155, "ush": 0.155,
	"dle": 0.155, "ber": 0.155, "lar": 0.155, "ors": 0.159, "ape": 0.159, "ces": 0.159,
	"eak": 0.159, "eed": 0.159, "ane": 0.159, "roo": 0.159, "air": 0.159, "ons": 0.159,
	"nne": 0.159, "hin": 0.159, "ora": 0.159, "rai": 0.159, "ass": 0.159, "als": 0.159,
	"ven": 0.159, "nch": 0.159, "ull": 0.159, "loo": 0.164, "nts": 0.164, "gle": 0.164,
	"mor": 0.164, "nks": 0.164, "par": 0.164, "mar": 0.164, "ans": 0.164, "pri": 0.164,
	"the": 0.164, "ure": 0.164, "tar": 0.164, "eep": 0.164, "sts": 0.168, "ton": 0.168,
	"att": 0.168, "ppe": 0.168, "arm": 0.168, "cre": 0.168, "tch": 0.168, "fla": 0.173,
	"rat": 0.173, "des": 0.173, "lan": 0.173, "str": 0.173, "hea": 0.173, "kes": 0.173,
	"for": 0.173, "con": 0.173, "ase": 0.173, "ise": 0.173, "sse": 0.177, "bar": 0.177,
	"eal": 0.177, "unt": 0.177, "ose": 0.177, "nds": 0.177, "cor": 0.177, "wed": 0.177,
	"nce": 0.182, "tal": 0.182, "eas": 0.182, "low": 0.182, "ook": 0.182, "ris": 0.182,
	"ind": 0.182, "ace": 0.182, "cho": 0.182, "cha": 0.182, "its": 0.182, "oll": 0.182,
	"igh": 0.182, "ard": 0.186, "ser": 0.186, "dge": 0.186, "win": 0.186, "uff": 0.186,
	"chi": 0.186, "bra": 0.186, "boo": 0.186, "nes": 0.186, "ire": 0.186, "unk": 0.186,
	"har": 0.186, "ens": 0.186, "ort": 0.186, "ust": 0.191, "ope": 0.191, "owe": 0.191,
	"amp": 0.191, "can": 0.191, "row": 0.191, "war": 0.191, "our": 0.191, "ten": 0.191,
	"ats": 0.191, "nde": 0.195, "lly": 0.195, "cra": 0.195, "tri": 0.195, "tin": 0.200,
	"ler": 0.200, "ist": 0.200, "ins": 0.200, "ded": 0.204, "hoo": 0.204, "min": 0.204,
	"ink": 0.204, "sto": 0.204, "ade": 0.209, "tes": 0.209, "pin": 0.209, "sed": 0.209,
	"ump": 0.209, "ame": 0.209, "uck": 0.209, "ash": 0.214, "end": 0.214, "gra": 0.218,
	"int": 0.218, "mer": 0.218, "ged": 0.218, "ain": 0.223, "ite": 0.223, "eat": 0.223,
	"lls": 0.223, "rin": 0.227, "che": 0.227, "lea": 0.227, "ned": 0.227, "ars": 0.227,
	"ale": 0.227, "nge": 0.227, "ies": 0.232, "med": 0.232, "car": 0.232, "tor": 0.232,
	"ank": 0.232, "tte": 0.236, "ail": 0.236, "use": 0.236, "ive": 0.236, "out": 0.236,
	"ice": 0.236, "ore": 0.236, "ree": 0.236, "ide": 0.236, "ger": 0.241, "and": 0.241,
	"art": 0.245, "tra": 0.245, "ock": 0.245, "ves": 0.245, "she": 0.250, "ile": 0.250,
	"ell": 0.250, "sha": 0.250, "ant": 0.254, "age": 0.254, "her": 0.254, "ran": 0.254,
	"ner": 0.254, "lle": 0.259, "oke": 0.259, "ove": 0.268, "man": 0.268, "one": 0.273,
	"rea": 0.273, "red": 0.273, "ang": 0.282, "ped": 0.282, "ses": 0.282, "are": 0.291,
	"cks": 0.291, "ast": 0.295, "all": 0.295, "les": 0.295, "sta": 0.295, "ick": 0.309,
	"lin": 0.309, "cke": 0.309, "ave": 0.314, "ker": 0.314, "led": 0.318, "ake": 0.318,
	"est": 0.327, "ill": 0.327, "ack": 0.327, "ver": 0.327, "ble": 0.332, "ent": 0.332,
	"ear": 0.332, "ste": 0.345, "ked": 0.350, "res": 0.354, "per": 0.354, "der": 0.354,
	"ine": 0.386, "ted": 0.400, "ate": 0.445, "ers": 0.454, "ter": 0.559, "ing": 1.154,
}
}


const SOUNDS = {
	GHOSTSOUND_1 = preload("res://mods/johnboat/sounds/ghostsound1.wav"),
	GHOSTSOUND_2 = preload("res://mods/johnboat/sounds/ghostsound2.wav"),
	GHOSTSOUND_3 = preload("res://mods/johnboat/sounds/ghostsound3.wav"),
	
	SUITCASE_1 = preload("res://mods/johnboat/sounds/suitcase1.wav"),
	SUITCASE_2 = preload("res://mods/johnboat/sounds/suitcase2.wav"),
}


const MIN_NGRAM_WEIGHT := 0.1
const COLD_CASE_EFFECT = preload("res://mods/johnboat/source/spells/cold_case/cold_case_effect_instance.tscn")

func is_ngram_valid(ngram: String, letter_pool: Array[String]) -> bool:
	var remaining_letter_pool = letter_pool.duplicate()
	for i in len(ngram):
		if ngram[i] in remaining_letter_pool:
			remaining_letter_pool.erase(ngram[i])
		else:
			return false
	
	
	return true

func get_ngram_pool(letter_pool: Array[String]) -> Dictionary[String,float]:
	var pool_for_value : Dictionary[String, float] = {}
	for ngram_length in range(3,0,-1):
		for val in range(8,0,-1):
			pool_for_value = get_ngram_pool_for_value(letter_pool,val,ngram_length)
			print_debug(pool_for_value)
			if len(pool_for_value) >= 3:
				return pool_for_value
	
	return {}


func get_ngram_pool_for_value(letter_pool: Array[String], value: int, ngram_length: int) -> Dictionary[String,float]:
	var ngram_pool: Dictionary[String,float] = {}
	var parity_key: String = ["START","END","OVERALL"][start_end_parity]
	var bigrams = SHORT_WORD_BIGRAMS[parity_key]
	var trigrams = SHORT_WORD_TRIGRAMS[parity_key]
	match ngram_length:
		3:
			for trigram in trigrams.keys():
				if Letters.get_string_value(trigram) == value and is_ngram_valid(trigram,letter_pool) and trigrams[trigram] > MIN_NGRAM_WEIGHT:
					ngram_pool[trigram] = trigrams[trigram]
		2:
			for bigram in bigrams.keys():
				if Letters.get_string_value(bigram) == value and is_ngram_valid(bigram,letter_pool) and bigrams[bigram] > MIN_NGRAM_WEIGHT:
					ngram_pool[bigram] = bigrams[bigram]
		1:
			for letter in Letters.LETTERS.keys():
				if Letters.get_string_value(letter) == value and is_ngram_valid(letter,letter_pool):
					ngram_pool[letter] = Letters.LETTERS[letter]
	
	return ngram_pool


func apply_to_tile(tile: Tile, _real_tile, is_preview, _is_preview_update):
	if is_preview:
		tile.add_status(TileStatus.MYSTERY)
		tile.add_status(TileStatus.FROZEN)
	
	tile.remove_status(TileStatus.CAPITAL)
	tile.remove_status(TileStatus.PERIOD)
	if not is_preview:
		var valid_tiles := tile_board.get_tiles({
			sorted=false, 
			custom_tile_check = func(tile: Tile, _parameters: Dictionary):
				if (len(tile.face) == 1):
					return tile.has_face() and !tile.has_status(TileStatus.MYSTERY)
				return false,
			exclude_tiles = [tile]
		})
		
		var letter_pool: Array[String] = []
		for t in valid_tiles:
			letter_pool.append(t.face)
			
		var ngram_pool := get_ngram_pool(letter_pool)
		
		AudioManager.play_sound(SOUNDS["SUITCASE_%d"%(randi_range(1,2))],.7,1.)
		#tile.add_poofcloud(POOF_COLOR,Globals.TILE_POOF_COLOR.frozen[1])
		
		if len(ngram_pool.keys()) < 1:
			tile.randomize_face([], rng.spell, false)
			tile.add_status(TileStatus.MYSTERY, rng.spell.randi())
			tile.add_status(TileStatus.FROZEN)
			#tile.add_poofcloud(tile.get_color())
			start_end_parity = (start_end_parity + 1)%3
			
			# TODO UNIFY THIS WITH NORMAL VFX
			return
		
		var ngram_choice = rng.spell.weighted_random(ngram_pool)
		
		var option_count: int = FIXED_OPTIONS_CAP
		
		var remaining_ngram_options = ngram_pool.duplicate()
		remaining_ngram_options.erase(ngram_choice)
		var chosen_ngram_options : Array[String] = [ngram_choice]
		for i in range(option_count - 1):
			if len(remaining_ngram_options) == 0:
				break
			var decoy_ngram = rng.spell.weighted_random(remaining_ngram_options)
			chosen_ngram_options.append(decoy_ngram)
			remaining_ngram_options.erase(decoy_ngram)
		
		(chosen_ngram_options.shuffle())
		var sseed = rng.spell.randi()
		
		var effect: GenericTileEffect = null
		var spelling_interval := 0.14
		
		effect = COLD_CASE_EFFECT.instantiate() as GenericTileEffect
		effect.do_play_sound = func():
			AudioManager.play_sound(SOUNDS["GHOSTSOUND_%d"%(start_end_parity+1)],.8,.65)
			tile.add_status(TileStatus.FROZEN)
			for i in len(ngram_choice):
				tile.set_face(ngram_choice.substr(0,i+1))
				#AudioManager.play_sound(Sounds.UI.TEXT_TYPING,1.)
				AudioManager.play_sound(Sounds.TILE.FROZEN,1.,1.)
				tile.add_status(TileStatus.MYSTERY,sseed, chosen_ngram_options)
				await Game.timeout(spelling_interval)
		
		var do_freeze := !tile.has_status(TileStatus.FROZEN)
		effect.frame_coords = tile.tile_sprite.base_sprite.frame_coords
		tile.tile_sprite.add_child(effect)
		effect.atlas = tile.tile_sprite.base_sprite.texture
		effect.dont_change = !do_freeze
		effect.bounce.connect(
			func():
				tile.animation.play("shake")
				)
		
		
		await effect.effect_finished
		start_end_parity = (start_end_parity + 1)%3
		
		frame_updated.emit()
	else:
		tile.set_face("aaa", true, false)

func get_hv_frames() -> Vector2i:
	return Vector2i(3, 1)


func get_frame() -> int:
	return start_end_parity


func is_tile_selectable(tile: Tile) -> bool:
	return (
		tile.is_face_modifiable()
		and not (
			tile.has_status(TileEffect.SHIMMERING)
		) and not (
			tile.has_harmful_status()
		) and not (
			tile.has_status(TileStatus.FROZEN) and len(tile.face) == 3
		)
	)
