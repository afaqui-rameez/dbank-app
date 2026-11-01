import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue : Float = 300.0;
  stable var startTime : Int = Time.now();

  public func topUp(amount : Float) : async () {
    if (amount > 0.0) {
      currentValue += amount;
      Debug.print(debug_show(currentValue));
    };
  };

  public func withdrawl(amount : Float) : async () {
    if (amount > 0.0 and currentValue >= amount) {
      currentValue -= amount;
      Debug.print(debug_show(currentValue));
    } else {
      Debug.print("Invalid withdrawal amount or insufficient balance.");
    };
  };

  public query func checkBalance() : async Float {
    currentValue
  };

  public func compound() : async () {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS : Float =
      Float.fromInt(timeElapsedNS / 1_000_000_000);

    currentValue :=
      currentValue * (1.01 ** (timeElapsedS / 31_536_000.0));

    startTime := currentTime;
  };
};