extends Node


# MEMBER VARIABLES
# For each correct answer score + 1
var score = 0
# How much student interacte with a teacher
var dialog_scene_counter = 0
# Gameover IF:
# 1 - If student interacte with a teacher more than 3 times without answer
# 2 - If teahcer choose wrong answer
var gameovercheck = false

var next_student = true

# PROGRAMMING -> C
var programming_c_questions = {
#28 вопросов:
#"Вопрос: Какое значение, по умолчанию, возвращает программа операционной системе в случае успешного завершения?\n\nОтвет: 1" : 0,
#"Вопрос: Какую функцию должны содержать все программы на С++?\n\nОтвет: main()" : 1,
#"Вопрос: Какие служебные символы используются для обозначения начала и конца блока кода?\n\nОтвет: begin: и end" : 0,
#"Вопрос: Какими знаками заканчивается большинство строк кода в Си++?\n\nОтвет: .(точка)" : 0,
#"Вопрос: Как обозначается комментарий в C++?\n\nОтвет: //" : 1,
#"Вопрос: Все ли перечисленные типы данных являются вещественными типами данных в C++ - float,double,real?\n\nОтвет: Да" : 0,
#"Вопрос: Оператор сравнения двух переменных\n\nОтвет: =" : 0,
#"Вопрос: Простые типы данных в С++\n\nОтвет: целые – int, вещественные – float или double, символьные – char" : 1,
#"Вопрос: Название С++ предложил\n\nОтвет: Рик Масситти" : 1,
#"Вопрос: Язык программирования C++ разработал\n\nОтвет: Билл Гейтс" : 0,
#"Вопрос: Программа, переводящая входную программу на исходном языке в эквивалентную ей выходную программу на результирующем языке, называется:\n\nОтвет: Компилятор" : 0,
#"Вопрос: Объявление константной переменной в С++, где type - тип данных в С++ variable - имя переменной value - константное значение\n\nОтвет: const type variable = value;" : 1,
#"Вопрос: Укажите правильное определение функции main в соответствии со спецификацией стандарта ANSI\n\nОтвет: int main(void)" : 1,
#"Вопрос: Чтобы подключить заголовочный файл в программу на С++, например iostream необходимо написать:\n\nОтвет: #include <> с iostream внутри скобок" : 1,
#"Вопрос: Чему будет равна переменная a, после выполнения этого кода \nint a;\n for(a = 0; a < 10; a++) {}?\n\nОтвет: 9" : 0,
#"Вопрос: До каких пор будут выполняться операторы в теле цикла while (x < 100)?\n\nОтвет: Пока х строго меньше ста" : 1,
#"Вопрос: Оператор, не являющийся циклом в С++?\n\nОтвет: while" : 0,
#"Вопрос: Цикл с постусловием?\n\nОтвет: do while" : 1,
#"Вопрос: Цикл с предусловием?\n\nОтвет: while" : 1,
#"Вопрос: Тело любого цикла выполняется до тех пор, пока его условие ...\n\nОтвет: Истинно" : 1,
#"Вопрос: Укажите правильную форму записи цикла do while\n\nОтвет: // форма записи оператора цикла do while:\ndo // начало цикла do while\n{\n/*блок операторов*/;\n}\nwhile (/*условие выполнения цикла*/); // конец цикла do while" : 1,
#"Вопрос: Какой служебный знак ставится после оператора case ?\n\nОтвет: =" : 0,
#"Вопрос: Какой оператор не допускает перехода от одного константного выражения к другому?\n\nОтвет: break;" : 1,
#"Вопрос: Какому зарезервированному слову программа передаёт управление в случае, если значение переменной или выражения оператора switch не совпадает ни с одним константным выражением?\n\nОтвет: default" : 1,
#"Вопрос: Каков результат работы следующего франмента кода?\nint x = 0;\n    switch(x)\n    {\n      case 1: cout << \"Один\";\n      case 0: cout << \"Нуль\";\n      case 2: cout << \"Привет мир\";\n    }\n\nОтвет: Нуль" : 0,
#"Вопрос: Общий формат оператора множественного выбора - switch\n\nОтвет: switch (switch_expression)\n{\n    case constant1: statement1; [break;]\n    case constant2: statement2; [break;]\n    case constantN: statementN; [break;]\n    [default: statement N+l;]\n}\n" : 1,
#"Вопрос: Что будет напечатано?\nint main()\n {\n    for (int i = 0; i < 4; ++i)\n    {\n       switch (i)\n       {\n          case 0  : std::cout << \"0\";\n          case 1  : std::cout << \"1\"; continue;\n          case 2  : std::cout << \"2\"; break;\n          default : std::cout << \"D\"; break;\n       }\n       std::cout << \".\";\n    }\n    return 0;\n }\n\nОтвет: 0112.." : 0,
#"Вопрос: В приведённом коде измените или добавьте один символ чтобы код напечатал 20 звёздочек - *.\nint i, N = 20;\nfor(i = 0; i < N; i--)\n    printf(\"*\")\n\nОтвет: int i, N = 20;\nfor(i = 0; i < N; N--)\n    printf(\"*\");" : 1

}


var programming_c_questions_lvl2 = {}

var programming_c_questions_lvl3 = {}

var programming_c_questions_lvl4 = {}

var all_programming_c_questions = [programming_c_questions, programming_c_questions_lvl2, programming_c_questions_lvl3, programming_c_questions_lvl4]

# Array keeps questions for different types of programming
var questions_programming = [all_programming_c_questions]

# For choose type questions for programming (C(0), Java(1), etc.)
var category_mode

# For choose types for discipline(Programming, Math, etc.)
var discipline_mode

var discipline = [questions_programming]

var c_level = 0
var java_level = 0
var level = 0

var levels = [c_level, java_level]
var level_mode

var can_go = false

var teacher_pos
var teacher_size

var door_programming_pos
var door_c_pos

var ekz_type

var name_ekz

var test_questions = {}



func questions_last(qsts):
	return qsts.size()

func ready_next_level(qsts):
	if(questions_last(qsts) == 0):
		return true
	else:
		return false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
