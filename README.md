## Templates for Superdrug

### Basic structure:

- Global Variables
- Image Data Variables
- Product Data Variables
  - Dynamically chooses data from either base data or offer data in variables where applicable
- Main Template 
  - Set output image size
  - Set basic propertier
- Utility Templates
- Layout Components
  - pinkBackground
    - Draws global Pink background using dithering pattern 
  - offerBox
    - Contains all logic for the box presenting offers
  - productDescription
    - Draws maker in bold and 2 lines of description. With dynamic text resizing to fit width to 1 or 2 lines respectively
  - priceBig
    - Draws the formated price, includes logic for special 'ONLY' offer
  - basePrice
    - Draws the baseprice
  - smallPriceAndBase
    - Draws unformated single line price + basePrice, used for "MEMBERS PRICE" offer types where main price is contained within the offerBox
  - infoLine
    - Draws article id, Ts&C
   - Barcode
     - Helper template for safely drawing a Code128 Barcode
- Main Layout
  - Contains component choose and placement logic

### Notes

- Maybe use separate templates for the different offerBox variants and contain only choosing logic in offerBox...


