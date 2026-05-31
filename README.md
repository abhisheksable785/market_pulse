# 📈 MarketPulse - Dynamic Market Simulator

MarketPulse is a Flutter-based stock market simulation application built using Flutter BLoC. The app simulates live stock price fluctuations, portfolio management, transaction tracking, and virtual trading without using any external APIs.

## 🚀 Features

### 📊 Live Market Simulation
- 5 Companies:
    - Apple
    - Tesla
    - Amazon
    - Google
    - Microsoft
- Random initial stock prices between ₹100 - ₹500
- Prices update automatically every 2 seconds
- Random increase/decrease between ₹1 - ₹20
- Live price change indicators

### 💰 Virtual Wallet
- Initial Balance: ₹10,000
- Dynamic wallet updates
- Balance decreases when buying shares
- Balance increases when selling shares

### 🛒 Buy Shares
- Buy shares of any company
- Validation for insufficient balance
- Portfolio updates automatically
- Transaction history recorded

### 💸 Sell Shares
- Sell owned shares
- Prevent selling shares not owned
- Prevent selling more shares than available
- Wallet updates automatically
- Transaction history recorded

### 📂 Portfolio Management
- Track owned shares
- Live portfolio value calculation
- Average buy price tracking
- Dynamic value updates with market price changes

### 📜 Transaction History
- Buy transactions
- Sell transactions
- Quantity tracking
- Price tracking
- Timestamp tracking

### 🎨 UI Features
- Modern Dark Theme
- Custom Bottom Navigation Bar
- Responsive Layout
- Live Market Ticker
- Interactive Buy/Sell Screens

---

## 🏗 Architecture

The project follows a clean and scalable architecture using Flutter BLoC.

```text
lib/
│
├── data/
│   └── models/
│       ├── company_model.dart
│       ├── portfolio_model.dart
│       └── transaction_model.dart
│
├── presentation/
│   ├── dashboard/
│   ├── portfolio/
│   ├── history/
│   ├── buy_share_screen/
│   ├── sell_share_screen/
│   └── splash/
│
├── logic/
│   └── bloc/
│
└── main.dart
```

---

## 🛠 State Management

- Flutter BLoC
- Event Driven Architecture
- Reactive UI Updates

---

## 📦 Dependencies

```yaml
flutter_bloc:
```

---

## 🎯 Assignment Requirements Covered

✅ Local Logic Only

✅ No APIs Used

✅ Random Price Generation

✅ Automatic Price Updates

✅ Buy Shares

✅ Sell Shares

✅ Virtual Wallet

✅ Portfolio Management

✅ Transaction History

✅ Flutter BLoC State Management

✅ Structured Code Architecture

---

## 📱 Screens

- Splash Screen
- Dashboard
- Portfolio
- Transaction History
- Buy Shares
- Sell Shares

---


### Built for Flutter Assessment - Dynamic Market Simulator
