// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract MyToken {

    // Address of contract Owner
    address owner;

    // ERC20 metadata
    string private _name;
    string private _symbol;

    uint256 private _totalSupply;

    mapping(address => uint256) private _balances;
    mapping (address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function decimals() public pure returns (uint256) {
        return 18;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        _spendAllowance(from, msg.sender, amount);
        _transfer(from, to, amount);
        return true;
    }

    function _transfer(address from, address to, uint256 amount) internal {
        require(_balances[from] >= amount, "You don't have that much!");
        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
    }

    function allowance(address _owner, address spender) public view returns (uint256) {
        return _allowances[_owner][spender];
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function mint(address to, uint256 amount) public onlyOwner returns (bool) {
        _totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
        return true;
    }

    function _approve(address _owner, address spender, uint256 amount) internal {
        _allowances[_owner][spender] = amount;
    }
    
    function _spendAllowance(address _owner, address spender, uint256 amount) internal {
        require(_allowances[_owner][spender] >= amount, "ERC20: Not enough allowance");
        _allowances[_owner][spender] -= amount;
        emit Approval(_owner, spender, _allowances[_owner][spender]);
    }

}
