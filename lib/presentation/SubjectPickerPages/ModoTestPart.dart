import 'package:flutter/material.dart';
import 'package:test_bilimlab_project/data/repository/school_class_reopsitory.dart';
import 'package:test_bilimlab_project/domain/modoClass.dart';

import '../../data/service/school_class_service.dart';
import '../../domain/entSubject.dart';
import '../../domain/testQuestion.dart';
import '../../domain/testSubject.dart';
import '../../utils/AppColors.dart';
import '../../utils/AppImages.dart';
import '../../utils/AppTexts.dart';
import '../../utils/questionTypeEnum.dart';
import '../Widgets/CustomDropDown.dart';
import '../Widgets/LongButton.dart';

class ModoTestPart extends StatefulWidget {
  const ModoTestPart({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<ModoTestPart> createState() => _ModoTestPartState();
}

class _ModoTestPartState extends State<ModoTestPart> {
  List<ModoClass> dropItems = [];
  bool _mounted = false;

  @override
  void initState() {
    _mounted = true;
    getClass();
    super.initState();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  Future<void> getClass() async {
    List<ModoClass> listOfClass = await SchoolClassService().getAllModoClass();
    if (_mounted) {
      setState(() {
        dropItems = listOfClass;
      });
    }
  }

  int? schoolClass;

  Future<void> onSelectClass(int subIndex) async {
    setState(() {
      schoolClass = subIndex;
    });
  }

  void onTestButtonPressed() {
    Navigator.pushNamed(context, '/test', arguments: [
      TestSubject(0, 'Математика', [
        TestQuestion(0, 'Количественные методы', ['Арифметика', 'Алгебра', 'Математический анализ', 'Дискретная математика'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(1, 'Графы и сети', ['Теория графов', 'Алгоритмы на графах', 'Маршрутизация в сетях', 'Транспортные сети'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(2, 'Математическая логика', ['Математические операции', 'Исчисление высказываний', 'Теория множеств', 'Модальная логика'], 3, QuestionTypeEnum.single,null,null),
        TestQuestion(3, 'Статистика и вероятность', ['Математическая статистика', 'Теория вероятностей', 'Регрессионный анализ', 'Байесовские методы'], 2, QuestionTypeEnum.multiple,null,null),
        TestQuestion(4, 'Дифференциальные уравнения', ['Обыкновенные дифференциальные уравнения', 'Частные дифференциальные уравнения', 'Теория управления', 'Колебания и волны'], 1, QuestionTypeEnum.multiple,null,null),
        TestQuestion(5, 'Математическая оптимизация', ['Линейное программирование', 'Нелинейное программирование', 'Генетические алгоритмы', 'Эвристические методы'], 4, QuestionTypeEnum.single,null,null),
        TestQuestion(6, 'Количественные методы', ['Арифметика', 'Алгебра', 'Математический анализ', 'Дискретная математика'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(7, 'Графы и сети', ['Теория графов', 'Алгоритмы на графах', 'Маршрутизация в сетях', 'Транспортные сети'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(8, 'Математическая логика', ['Математические операции', 'Исчисление высказываний', 'Теория множеств', 'Модальная логика'], 3, QuestionTypeEnum.single,null,null),
        TestQuestion(9, 'Статистика и вероятность', ['Математическая статистика', 'Теория вероятностей', 'Регрессионный анализ', 'Байесовские методы'], 2, QuestionTypeEnum.multiple,null,null),
        TestQuestion(10, 'Дифференциальные уравнения', ['Обыкновенные дифференциальные уравнения', 'Частные дифференциальные уравнения', 'Теория управления', 'Колебания и волны'], 1, QuestionTypeEnum.multiple,null,null),
        TestQuestion(11, 'Математическая оптимизация', ['Линейное программирование', 'Нелинейное программирование', 'Генетические алгоритмы', 'Эвристические методы'], 4, QuestionTypeEnum.single,null,null),
      ]),
      TestSubject(1, 'Физика', [
        TestQuestion(0, 'Механика', ['Кинематика', 'Динамика', 'Статика', 'Гидродинамика'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(1, 'Термодинамика', ['Тепловые процессы', 'Уравнение состояния газа', 'Термодинамические циклы', 'Теплопередача'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(2, 'Электромагнетизм', ['Электростатика', 'Магнетизм', 'Электромагнитные колебания', 'Электромагнитные волны'], 3, QuestionTypeEnum.single,null,null),
        TestQuestion(3, 'Оптика', ['Геометрическая оптика', 'Физическая оптика', 'Квантовая оптика', 'Лазеры и оптические волокна'], 2, QuestionTypeEnum.multiple,null,null),
        TestQuestion(4, 'Атомная физика', ['Строение атома', 'Радиоактивность', 'Квантовая механика', 'Ядерная физика'], 1, QuestionTypeEnum.multiple,null,null),
        TestQuestion(5, 'Физика элементарных частиц', ['Стандартная модель', 'Кварки и лептоны', 'Бозоны', 'Эксперименты в физике элементарных частиц'], 4, QuestionTypeEnum.single,null,null),
      ]),
      TestSubject(2, 'Матсау', [
        TestQuestion(0, 'Информационные технологии', ['Программирование', 'Базы данных', 'Сетевые технологии', 'Веб-разработка'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(1, 'Искусственный интеллект', ['Машинное обучение', 'Нейронные сети', 'Обработка естественного языка', 'Компьютерное зрение'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(2, 'Компьютерная архитектура', ['Процессоры', 'Память', 'Периферийные устройства', 'Организация вычислительных систем'], 3, QuestionTypeEnum.single,null,null),
        TestQuestion(3, 'Информационная безопасность', ['Криптография', 'Защита от взлома', 'Безопасность сетей', 'Этические аспекты в IT'], 2, QuestionTypeEnum.multiple,null,null),
        TestQuestion(4, 'Системное программирование', ['Операционные системы', 'Драйверы', 'Системное программное обеспечение', 'Разработка ядра операционной системы'], 1, QuestionTypeEnum.multiple,null,null),
        TestQuestion(5, 'Интернет вещей', ['Архитектура IoT', 'Сенсоры и актуаторы', 'Протоколы связи', 'Проектирование IoT-систем'], 4, QuestionTypeEnum.single,null,null),
      ]),
      TestSubject(3, 'Тарих', [
        TestQuestion(0, 'Древний мир', ['Древний Египет', 'Древний Восток', 'Греция', 'Римская империя'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(1, 'Средневековье', ['Византия', 'Великое переселение народов', 'Феодальная Европа', 'Крестовые походы'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(2, 'Эпоха Возрождения', ['Искусство Возрождения', 'Наука Возрождения', 'Литература Возрождения', 'Географические открытия'], 3, QuestionTypeEnum.single,null,null),
        TestQuestion(3, 'Новое время', ['Эпоха Просвещения', 'Французская революция', 'Индустриальная революция', 'Колониальное время'], 2, QuestionTypeEnum.multiple,null,null),
        TestQuestion(4, 'Первая мировая война', ['Причины и последствия', 'Битвы и операции', 'Дипломатия и политика', 'Домашний фронт'], 1, QuestionTypeEnum.multiple,null,null),
        TestQuestion(5, 'Вторая мировая война', ['Начало и конец войны', 'Фронты и битвы', 'Голокост', 'Военные технологии'], 4, QuestionTypeEnum.single,null,null),
      ]),
      TestSubject(4, 'Окусау', [
        TestQuestion(0, 'Мировая кулинария', ['Французская кухня', 'Итальянская кухня', 'Азиатская кухня', 'Африканская кухня'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(1, 'Искусство кулинарии', ['Готовка мяса', 'Пекарское искусство', 'Десерты и кондитерские изделия', 'Напитки и коктейли'], 2, QuestionTypeEnum.single,null,null),
        TestQuestion(2, 'Национальные кухни', ['Японская кухня', 'Индийская кухня', 'Мексиканская кухня', 'Традиционная русская кухня'], 3, QuestionTypeEnum.single,null,null),
        TestQuestion(3, 'Здоровое питание', ['Вегетарианство', 'Фитнес-питание', 'Органические продукты', 'Диеты и похудение'], 2, QuestionTypeEnum.multiple,null,null),
        TestQuestion(4, 'Кулинарные приемы', ['Техника приготовления', 'Кулинарные секреты', 'Основные способы приготовления', 'Украшение блюд'], 1, QuestionTypeEnum.multiple,null,null),
        TestQuestion(5, 'Кулинарные традиции', ['Праздничные блюда', 'Семейные рецепты', 'Традиционные кулинарные обычаи', 'Гастрономические фестивали'], 4, QuestionTypeEnum.single,null,null),
      ]),
    ]
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(onPressed: (){widget.onPressed();}, child: Text('< ${AppText.entTest}', style: const TextStyle(fontSize: 16),)),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppText.modoTest ,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.colorBackgroundGreen,
                  borderRadius: BorderRadius.circular(130),
                ),
                child: Center(
                    child: SizedBox(
                        height: 120,
                        child: Image.asset(AppImages.pie_chart)
                    )
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: 250,
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.colorTextFiledStoke),
                ),
                child: DropdownButton<int>(
                  isExpanded: true,
                  menuMaxHeight: 250,
                  hint: Text(AppText.modoClass),
                  value: schoolClass,
                  items: dropItems.map<DropdownMenuItem<int>>((ModoClass schoolClass) {
                    return DropdownMenuItem<int>(
                      value: schoolClass.id,
                      child: Text(
                        schoolClass.name,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      onSelectClass(newValue);
                    }
                  },
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width:250,
                  child: LongButton(onPressed: onTestButtonPressed, title: AppText.startTest)
              )

            ],
          ),
        ),
      ],
    );
  }
}
