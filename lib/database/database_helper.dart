import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ant_control.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE periods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year INTEGER NOT NULL,
        month INTEGER NOT NULL,
        UNIQUE (year, month)
      );
    ''');

    await db.execute('''
      CREATE TABLE banks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE account_types (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE currencies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        symbol TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        type TEXT CHECK(type IN ('income', 'saving', 'fixed_expense', 'variable_expense')) NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        bank_id INTEGER NOT NULL,
        account_type_id INTEGER NOT NULL,
        currency_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        FOREIGN KEY (bank_id) REFERENCES banks(id),
        FOREIGN KEY (account_type_id) REFERENCES account_types(id),
        FOREIGN KEY (currency_id) REFERENCES currencies(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE account_monthly_configurations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_id INTEGER NOT NULL,
        month_id INTEGER NOT NULL,
        initial_amount REAL NOT NULL,
        balance REAL NOT NULL,
        end_amount REAL NOT NULL,
        FOREIGN KEY (account_id) REFERENCES accounts(id),
        FOREIGN KEY (month_id) REFERENCES months(id),
        UNIQUE (account_id, month_id)
      );
    ''');

    await db.execute('''
      CREATE TABLE category_monthly_configurations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        month_id INTEGER NOT NULL,
        monthly_budget REAL NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        FOREIGN KEY (month_id) REFERENCES months(id),
        UNIQUE (category_id, month_id)
      );
    ''');

    await db.execute('''
      CREATE TABLE incomes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        account_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        month_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        FOREIGN KEY (account_id) REFERENCES accounts(id),
        FOREIGN KEY (month_id) REFERENCES months(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE savings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        from_account_id INTEGER NOT NULL,
        to_account_id INTEGER NOT NULL,
        date TEXT NOT NULL,
        month_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        FOREIGN KEY (from_account_id) REFERENCES accounts(id),
        FOREIGN KEY (to_account_id) REFERENCES accounts(id),
        FOREIGN KEY (month_id) REFERENCES months(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE fixed_expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        budget REAL NOT NULL,
        due_date TEXT NOT NULL,
        actual_amount REAL,
        payment_date TEXT,
        account_id INTEGER,
        month_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        FOREIGN KEY (account_id) REFERENCES accounts(id),
        FOREIGN KEY (month_id) REFERENCES months(id)
      );
    ''');

    await db.execute('''
      CREATE TABLE variable_expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        account_id INTEGER NOT NULL,
        month_id INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(id),
        FOREIGN KEY (account_id) REFERENCES accounts(id),
        FOREIGN KEY (month_id) REFERENCES months(id)
      );
    ''');
  }
}
