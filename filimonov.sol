pragma solidity ^0.5.8; // support down to 0.4.0 compiler versions and up to 0.5.8

contract faucet {
    
    
            //declarations
            	address public from_addr;
            	
            	uint public amt_max = 0.1 ether;
            
                mapping (address => bool) public addresses;
            	
                event ether_transfer(address to_address, uint amount);
                
                
            //constr    
                constructor () public {
                    from_addr = msg.sender;
                }
            
                function () payable external {
                }
            
                function get_balance() public view returns (uint) {
                    return address(this).balance;
                }
            
                function ether_transfer_reqs(uint coins) public {
                    		require(address(this).balance >= coins, "У Вас недостаточно баланса =(");
                            require(coins > 0, "К сожалению сумма не может быть отрицательной =(");
                            if (msg.sender != from_addr) {
                                        require(addresses[msg.sender] == false, "Допускается не более одного трансфера");
                                        require(coins <= amt_max, "Превышен размер максимальной транзакции");
                                        addresses[msg.sender] = true;
                            }
                            msg.sender.transfer(coins);
                            emit ether_transfer(msg.sender, coins);
                }
}