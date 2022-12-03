# Homework 16

1. Setup an account on NFT Storage.


2. Upload an image and then associate this image with one of your Volcano NFTs. Think
about a way of automating image generation.


3. In the NFT Metadata - set some attributes/traits which can be viewed on OpenSea.
Example

<img width="970" alt="Screenshot 2022-12-03 at 21 27 06" src="https://user-images.githubusercontent.com/81931426/205463061-0b3a8542-f729-444c-8f44-add7e268c380.png">


4. See if you can figure out how to store the NFT Metadata on chain within your NFT
Contract. Hint look into the Base64 library. Example

We can register the Metadata on chain within the smart contract with the minting function as we can see in the example:

  function makeAnEpicNFT() public {
    uint256 newItemId = _tokenIds.current();

    string memory first = pickRandomFirstWord(newItemId);
    string memory second = pickRandomSecondWord(newItemId);
    string memory third = pickRandomThirdWord(newItemId);
    string memory combinedWord = string(abi.encodePacked(first, second, third));

    string memory finalSvg = string(abi.encodePacked(baseSvg, combinedWord, "</text></svg>"));

    // Get all the JSON metadata in place and base64 encode it.
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    // We set the title of our NFT as the generated word.
                    combinedWord,
                    '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                    // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    // Just like before, we prepend data:application/json;base64, to our data.
    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

    console.log("\n--------------------");
    console.log(finalTokenUri);
    console.log("--------------------\n");

    _safeMint(msg.sender, newItemId);
    
    // Update your URI!!!
    _setTokenURI(newItemId, finalTokenUri);
  
    _tokenIds.increment();
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
  }
