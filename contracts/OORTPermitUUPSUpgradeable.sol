// SPDX-License-Identifier: MIT
// Further information: https://docs.openzeppelin.com/contracts/4.x/api/proxy#UUPSUpgradeable
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/**
** Upgradeable Standard ERC20 Contract Proxy For OORT
 */

contract OORTUUPS is
  Initializable,
  ERC20Upgradeable,
  ERC20BurnableUpgradeable,
  PausableUpgradeable,
  AccessControlUpgradeable,
  ERC20PermitUpgradeable,
  UUPSUpgradeable
{
  bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
  bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
  bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() initializer {}

  function initialize() public initializer {
    __ERC20_init("OORTUUPS", "OORT");
    __ERC20Burnable_init();
    __Pausable_init();
    __AccessControl_init();
    __ERC20Permit_init("OORTUUPS");
    __UUPSUpgradeable_init();

    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _setupRole(PAUSER_ROLE, msg.sender);
    _mint(msg.sender, 10000 * 10**decimals());
    _setupRole(MINTER_ROLE, msg.sender);
    _setupRole(UPGRADER_ROLE, msg.sender);
  }

  function pause() public onlyRole(PAUSER_ROLE) {
    _pause();
  }

  function unpause() public onlyRole(PAUSER_ROLE) {
    _unpause();
  }

  function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
    _mint(to, amount);
  }

  function _beforeTokenTransfer(
    address from,
    address to,
    uint256 amount
  ) internal override whenNotPaused {
    super._beforeTokenTransfer(from, to, amount);
  }

  function _authorizeUpgrade(address newImplementation)
    internal
    override
    onlyRole(UPGRADER_ROLE)
  {}
}
