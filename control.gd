extends Control

# 中文 英文 日语 韩语 泰语 阿拉伯语 俄语 印尼语 菲律宾语 德语 西班牙语
# (ISO 639-1 language codes)
var language_codes = ["zh", "en", "ja", "ko", "th", "ar", "ru", "id", "tl", "de", "es"]

var languages = ["中文", "英文", "日语", "韩语", "泰语", "阿拉伯语", "俄语", "印尼语", "菲律宾语", "德语", "西班牙语"]

#var script_codes = ["Hani", "Latn", "Hrkt", "Kore", "Thai", "Arab", "Cyrl", "Latn", "Latn", "Latn", "Latn"]

var lang_item = preload("res://language_item.tscn")

var preview_text = [
	"你好世界",
	"hello world",
	"こんにちは世界",
	"안녕 세계",
	"สวัสดีชาวโลก",
	"مرحبا بالعالم",
	"Привет, мир",
	"Halo Dunia",
	"kumusta mundo",
	"Hallo Welt",
	"Hola Mundo",
]

func _ready() -> void:
	get_window().connect("files_dropped", files_dropped)
	
	var font = load("res://OpenSans-Regular.ttf")
	set_font(font)


func reload():
	for c in $HBoxContainer/VBoxContainer.get_children():
		c.queue_free()
		
	for i in range(languages.size()):
		var item = lang_item.instantiate()
		item.set_language(languages[i])
		item.set_preview_text(preview_text[i])
		$HBoxContainer/VBoxContainer.add_child(item)


func files_dropped(files):
	if files.size() > 0:
		var font_path = files[0]
		
		var font = FontFile.new()
		font.data = FileAccess.get_file_as_bytes(font_path)
		
		if font is Font:
			set_font(font)


func set_font(font: Font):
	font.set_allow_system_fallback(false)
	theme.default_font = font
	reload()
	
