// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CanDraw {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    struct Player {
        address player;
        uint256 amount;
    }

    Player[] public players;
    uint public totalAmount;
    uint public totalInvest;
    uint public limit = 5;
    uint public investLimit = 1 * 10**18;

    event Invest(address indexed adres, uint amount);
    event Winner(address indexed adres, uint amount);

    fallback() external payable {
        require(msg.value != 0, "");
    }

    receive() external payable {
        require(msg.value != 0, "");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You need to be authorized");
        _;
    }

    function random(uint number) public view returns (uint) {
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        block.timestamp,
                        block.difficulty,
                        msg.sender
                    )
                )
            ) % 100;
    }

    function deposit() public payable {
        require(msg.value > 0, "");
        require(msg.sender != address(0));

        Player memory p = Player({player: msg.sender, amount: msg.value});

        players.push(p);
        totalAmount += msg.value;
        totalInvest++;

        emit Invest(msg.sender, msg.value);

        if (totalInvest == limit) {
            address winnerAddress = players[random(limit)].player;
            uint earnedAmount = totalAmount;
            winner(winnerAddress, earnedAmount);
            delete players;
            totalAmount = 0;
            totalInvest = 0;
        }
    }

    function winner(address _address, uint _amount) internal {
        payable(_address).transfer(_amount);
        emit Winner(_address, _amount);
    }

    function setLimit(uint _limit) public {
        limit = _limit;
    }

    function setInvestLimit(uint _limit) public onlyOwner {
        investLimit = _limit;
    }
}
