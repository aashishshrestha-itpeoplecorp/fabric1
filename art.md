
# Use Case – Art Auction

## **Section 1 - Intro**

### **Overview of the Business Problem or Opportunity**

Art auction industry is becoming more and more decentralized, while Sotheby &amp; Christi are still at the forefront, rise of numerous smaller players often make it difficult to establish authenticity of art.

Maintaining a trail of transactions where art changes hands is difficult. Also, as more and more affordable art is going through auction route, it is difficult for current systems to service this market in a cost effective and all inclusive way.

### **Current Solution**

Currently online auction companies operate over the internet and act as the middlemen operating on behalf of the art owners and receiving bids online from buyers. Authenticity of the art is verified by these auction houses offline and certificate of provenance are provided as part of the sale. Some of such auction houses are [Paddle8](http://paddle8.com/),  [Artnet](http://artnet.com/), and  [Auctionata](http://auctionata.com/).

### **Why Distributed Ledger technology?**

Block Chain can provide over-encompassing platform for Buyers and Sellers or Traders, Banks, Insurance Companies, Shipping and Forwarding, Auction Houses, Art Dealers, Artists to perform simultaneously. The chains associated with these transactions also provide an immutable record of the change of ownership across auction houses and transactions, and serves as a single source of truth.

On the network each of the players can exist as nodes, while the art itself can be modeled as colored coins, which are transacted amongst the nodes. Smart contracts can be created to take care of the auctioneering process. While monetary transactions need to be settle with an escrow like functionality.

The platform can be availed by the participating entities which can register themselves over initial chain, once validated; the participants can be enabled and connected to the Art Auction chain itself. Valid participants can perform their expected functions like creating assets, querying owner details, transfer ownerships, bid and buy over the platform.

By using block chain the system also becomes automatically time stamped and can be audited later. The block chain would also act as a record of all transactions and activities of all the players, acting as a check on fraudulent actors.

### **Opportunity/Justification**

TBC

## **Section 2 - User Stories and Requirements**

_User requirements_

**Common requirements**

1. Condition &amp; authenticity of the art
2. Safe, secure &amp; fair bidding platform
3. Authenticated actors on the platform, who can be trusted

**Buyers and Sellers or Traders (TRD)**

1. Clean financial settlements
2. Clear ownership and provenance maintenance
3. Tracing the custody details of the item in transit

**Banks (BNK)**

1. Adhering to regulations for all transactions
2. Clear KYC &amp; AML requirements for all players
3. Easy and clean process for settling successful and unsuccessful bids

**Insurance Companies (INS)**

1. Access to the condition of art for underwriting purposes
2. Tracing the custody details of the item during transaction and transit
3. Reliable valuation of the art, based on item&#39;s historical pricing details

**Shipping and Forwarding (SHP)**

1. Clear and provable change of titles on delivery
2. Logged GPS data on block chain to enable proof of delivery
3. Mobile based interface for remote access and updation of the blockchain

**Auction Houses (AH)**

1. Need easy medium for validation of ownership history of the item
2. Need to ascertain that any provenance provided cannot be faked or reproduced
3. Easily enforceable and flexible models for charging commissions and charges

**Art Dealers (DEL)**

1. Apart from usual requirements from buyers &amp; sellers, art dealers need an easier way to manage their inventories of art and funds
2. Better interface to curate art on the platform
3. Ability to work on behalf of a buyer or a seller, hence need functionality to transfer ownership to/from their clients

**Artists (ART)**

1. Need easier ways to connect to auction houses
2. Catalogue for posting and retrieving details of their art
3. Simpler ways to get the funds transferred to their bank accounts

**Art Item Creation Story**

_User Profile 1 : Chris is a modern art painter. He currently sells his paintings in art exhibitions and online on eBay type websites. As he is fairly known by now in art circles and is looking at auctioning some of his best works online. However he has not yet decided on the platform he would like to use._

_User Story 1_

- Chris hears from a friend about Art Auction App, based on HyperLedger
- He checks about it, and finds reliable organizations are involved in building and maintenance of the platform, and various Art Auction Houses are also part of the network
- He goes and registers herself as an artist, based on the details he has provided her membership and role gets validated and he is connected on the platform
- He gets an invite from multiple Auction house to connect and discuss about his Auctioning needs
- Meanwhile he also adds items he wants to auction and details regarding the style, origin and other parameters
- Over the next week he meets with few of these Auction Houses and discusses the fees and charges and valuation methodologies and provenance processes
- Based on his discussion, he connects with one of the auction houses and invites their representatives to visit him for having a look at items he wants to auction
- Based on physical verification, Auction House put a value and assign a start date, close date and floor price, buy it now price if applicable, of the auction on the platform
- Once these auction starts, the Chris can actually see all the bids which are placed and when
- Once the auction closes, Chris receives the money from Auction House&#39;s banks account to his bank account within a week
- In future, he can even track who owns his art piece and the whole history of the ownership
- And, he is surprised to know that he need not be just connected to one particular auction house and can use services of other players for his future art auctions

**Art Item Seller Side Story**

_User Profile 2 –_ Dave, is a part-time art trader, apart from his usual accountant job. He is fairly busy in his regular job and mostly buys and sells through his trusted arts dealer. He wants to sell through auction route, but again he wants his dealer to take care of all the groundwork.

_User Story – 2_

- Dave wants to sell some his collections through the auction route
- He directs his Auction dealer to sell on his behalf
- His dealer is already aware of the offline auctions, but feels that the buyers and sellers commission charges there are too high for these items
- The dealer is also a part of the Hyperledger Auction App platform
- He put the collection for auction on the platform for any auction house to pick and make part of their catalogue
- Few of the auction houses connect directly with the dealer to find details of the items
- Dealer explains them about the item and tells them that Dave is the owner of the items
- Auction house ask Dealer and Dave to update the ownership details of the items
- Dealer also updates the commission he would be charging and other charges applicable on sale, which Dave validates
- Which are then validated by the Auction house, and later put on auction
- Once bidding starts Dealer and Dave can have a look at the prices at which bids are taking place
- On successful auction dealers and auction house commissions and charges are transferred to respective parties from the buyers account, while the remaining amount is transferred to Dave&#39;s account
- Also, in case of any applicable Artist Resale Right, equivalent amount is transferred to the Auction house for payment to the Artist or Artist&#39;s estate

**Art Item Buyer side story**

_User Profile 3 –_ Mary, an art enthusiast and connoisseur and entrepreneur, likes buying medieval paintings in the mid-price range, but she is really busy with her job and its difficult for her to take out time to visit offline auctions.

_User Story 3 –_

- Mary hears from a friend about Art Auction App, based on HyperLedger.
- She checks about it, and finds reliable organizations are involved in building and maintenance of the platform
- She goes and registers herself as a buyer, based on the details she has provided her membership and role gets validated.
- Once part of the platform, she can now use her private key to check all the items up for auction, retrieve ownership and creation history of these items
- She can now check reviews, condition description provided by the auction house for that item
- She can also see the shipping &amp; forwarding agents, dealers, insurance and banks which are involved for each item, along with charges and commission she would be paying to each of these
- All this assures her that she is in a safe zone, she also has visibility of the process on the platform itself
- She now places bids for her preferred item, based on type of auction gets updates regarding higher bids placed, items she was able to secure in the auctions
- She can at the end of the auction, see the status of her items, which are in transit and under the safe custody of the shipping and forwarding agent
- Once she gets the item, in desired condition, the ownership details start pointing to her.
- She is also aware that now everyone on the platform can see her as the rightful owner and that can provide provenance for any future sales

## **Section 3 - Requirements Not Related to User Stories**

TBC

- **Error Management** - As the number of nodes grow, there should be a way of detecting, routing and handling errors using standard and or custom error handlers for chaincode and business errors
- **Event Management** - The auction application generates an event such as the expiry of an auction. Triggering an invoke from within a thread spawned by the chaincode violates the FSM. Hence, a better mechanism to listen to events and invoke appropriate actions on the chaincode is required
- Both **UTC and Location management** should be supported on the Hyperledger Fabric. In the Auction Application, each peer may be in a different time zone and location , and their clocks may not be in sync when recording a transaction processed at the end of a timed event
- Better techniques to **query the Blockchain database**. In the auction application, query by asset ID and query by asset category require two different tables and to improve efficiency, we duplicate the item information in both tables

## **Section 4 - External References and Glossary**

TBC