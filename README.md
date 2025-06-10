# Value Area Expert Advisor (MT5)

This is an experimental Expert Advisor (EA) developed for MetaTrader 5, built around the concept of the **Value Area** and **Point of Control (POC)** from volume profile analysis.

The strategy is based on the classic 80% Value Area rule:
> If price opens outside the previous session’s Value Area and re-enters it, there is a high probability (~80%) that it will traverse the entire area.

This project is intended to **explore**:
- How to calculate the Value Area (VAL, VAH, and POC) programmatically
- Entry logic when price returns to the Value Area
- Potential use of **Swing High/Low** levels for trend identification
- How to integrate technical context into automated trading

---

## ⚠️ Disclaimer

This project is for **educational purposes only**.

I make **no guarantees** about performance, profitability, or accuracy.  
Use it at your **own risk**.  
I am **not responsible** for any financial losses or damage that may occur from using this software.

---

## 🔧 Technical Overview

- **Platform**: MetaTrader 5 (MQL5)
- **Strategy Type**: Volume profile-based logic with Value Area and POC
- **Features**:
  - Dynamic Value Area calculation
  - Basic swing high/low detection
  - Entry logic based on 80% rule
  - Experimental trend filtering

---

## 📚 Notes

This is a **learning project**. The code may be incomplete or under active development.  
Contributions and suggestions are welcome, but please understand the primary goal is self-education and experimentation.

---

## 📄 License

This project is released under the [MIT License](LICENSE).
