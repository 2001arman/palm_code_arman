# 📚 PalmCode Technical Test – Book App

This is a Book App developed as part of the technical test for PalmCode.  
Created by **Muhammad Arman Maulana**.

---

## 🚀 How to Run the Project

1. Get all dependencies:
   ```bash
   flutter pub get
   ```
2. Generate necessary files (for hive and mockito ):
    ```bash
    flutter pub run build_runner build
    ```


---

## 🧱 Architecture
This project follows **Clean Architecture** with **Domain-Driven Design (DDD)** principles. It is structured into **four layers: Presentation, Application, Domain, and Infrastructure** — ensuring the codebase remains clean, scalable, and maintainable.

![image](https://github.com/user-attachments/assets/2d1b5e87-abb8-45c2-8a94-43bc6eb97860)

<img width="251" alt="Screenshot 2025-06-29 at 23 57 33" src="https://github.com/user-attachments/assets/ec203b67-5b86-4abc-837a-7ffc37ce517a" />

---

## 🛠 Error Handling
This app uses the 'Onion Architecture' style error handling via the Either type from the dartz package:

- ```Left``` represents failure or error

- ```Right``` represents success and valid data

### Example
Below is an example of the error handling pattern in the **BookRemoteDataSource** class:
```dart
Future<Either<HttpException, BooksResponse>> getBooks(String url) async {
  try {
    final pageUrl = Uri.parse(url);
    final response = await http.get(pageUrl);

    if (response.statusCode == 200) {
      return Right(BooksResponse.fromRawJson(response.body));
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  } on HttpException catch (e) {
    return Left(e);
  } on http.ClientException catch (e) {
    return Left(HttpException(e.message));
  } catch (e) {
    return Left(HttpException(e.toString()));
  }
}
```

---

## 🗂️ Local Cached Data
I use **Hive** to store book data locally. Both the list of **favorite books** and the **first page of book data** are cached to improve the user experience.

---

## 🧪 Unit Test
I use **Mockito** to write unit tests for the ```BookRemoteDataSource``` class.
These tests cover both successful data retrieval and failure scenarios.

To run the test, use the following command:
```bash
flutter test test/data/book_remote_test.dart   
```
