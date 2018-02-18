pragma solidity ^0.4.16;

/* Hermod Token */

contract HermodToken {

    string public standard = 'HermodToken';
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public sellPrice;
    uint256 public buyPrice;

    function HermodToken() {
        totalSupply = 1000000000;
        balanceOf[this] = totalSupply;
        name = 'Hermod';
        symbol = 'MAIL';
        decimals = 0;
        sellPrice = 1000000000000000;
        buyPrice = 1000000000000000;
    }

    mapping (address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) revert();
        if (balanceOf[_to] + _value < balanceOf[_to]) revert();
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
    }

    function () payable {
        uint amount = msg.value / buyPrice;
        if (balanceOf[this] < amount) revert();
        balanceOf[msg.sender] += amount;
        balanceOf[this] -= amount;
        Transfer(this, msg.sender, amount);
    }

    function sell(uint256 amount) {
        if (balanceOf[msg.sender] < amount ) revert();
        balanceOf[this] += amount;
        balanceOf[msg.sender] -= amount;
        if (!msg.sender.send(amount * sellPrice)) {
            revert();
        } else {
            Transfer(msg.sender, this, amount);
        }
    }

}
