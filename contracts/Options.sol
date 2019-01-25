pragma solidity ^0.5.0;

// Time excercize optino. Time synced, so can't manipulate

contract Options {

  event OptionCreated(uint256 id);

  struct OptionT {
    address assetOwner;
    address optionOwner;
    uint256 strikeFiat;
    uint256 premiumFiat;
    uint256 expTime_sec;
    uint256 optionQuantity;
    // address optionAddress;
  }

  mapping (uint => OptionT) options;
  uint256 public counter;

  // function createOption(address token, uint256 tokenQuantity, uint256 strike_18, uint256 premium, uint256 expTime_sec) public payable {
  function createOption(uint256 strikeFiat, uint256 premiumFiat, uint256 expTime_sec, uint optionQuantity) public payable returns (uint id) {
    require(expTime_sec > block.timestamp);
    require(optionQuantity == msg.value);

    options[counter].assetOwner = msg.sender;
    options[counter].strikeFiat = strikeFiat;
    options[counter].premiumFiat = premiumFiat;
    options[counter].expTime_sec = expTime_sec;
    options[counter].optionQuantity = optionQuantity;
    counter += 1;
    emit OptionCreated(counter - 1);
    return counter - 1;
  }

  function excerciseOption(uint id) public {
    // oracle here
  }
  // callback() { _payoutOption() }

  function reclaimOption(uint id) public {
    uint256 optionQuantity = options[id].optionQuantity;

    require(msg.sender == options[id].assetOwner);
    require(block.timestamp > options[id].expTime_sec);

    // Re-entrant guarded
    delete options[id];
    require(msg.sender.send(optionQuantity));
  }

  function _payoutOption(uint256 id) private {
   OptionT memory option = options[id];
   // option
  }
}

