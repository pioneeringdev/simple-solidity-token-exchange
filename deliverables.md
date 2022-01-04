### Source code
AlphaToken: https://rinkeby.etherscan.io/address/0x52ecc9304Ae8f35dfE28f26b703e9ABcfF01B0F7#code

BetaToken: https://rinkeby.etherscan.io/address/0x2Fa0Ee8Da50beb12667359233E749be469344E60#code

WrapperToken: https://rinkeby.etherscan.io/address/0x40F0c91340AF0b1F11987eEED3B964F6a09AeE6f#

### Addresses
alpha: 0x52ecc9304Ae8f35dfE28f26b703e9ABcfF01B0F7
beta:  0x2Fa0Ee8Da50beb12667359233E749be469344E60
wrapper: 0x40F0c91340AF0b1F11987eEED3B964F6a09AeE6f

### Call Sequence
1. Deploy TokenA
2. Deploy TokenB
3. Deploy Wrapper(address(TokenA), address(TokenB));
4. TokenA.approve(address(Wrapper), amount);
5. Wrapper.swap(address(TokenA), amount);
6. TokenB.approve(address(Wrapper), amount);
7. Wrapper.unswap(address(TokenB), amount);
