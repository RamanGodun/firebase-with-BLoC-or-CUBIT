// @autoSerializable
// /*
// Макрос @autoSerializable автоматично згенерує необхідні методи для серіалізації (toJson() та fromJson()),
//  що спрощує роботу розробників та зменшує кількість коду.
//  */

// @autoCopyable
// /*
// Тут @autoCopyable автоматично згенерує метод copyWith,
// що дозволить змінювати деякі поля об’єкта без необхідності створювати їх вручну.
//  */

// @autoValidated
// /*
// Макрос @autoValidated згенерує необхідний код для валідації кожного поля класу,
// що спрощує процес та дозволяє уникнути написання повторюваного коду.
//  */

// class User {
//   final String name;

//   @Min(18)
//   @Max(100)
//   final int age;

//   User(this.name, this.age) {
//     if (age < 0) {
//       throw ArgumentError('Age must be positive');
//     }
//   }
// }
