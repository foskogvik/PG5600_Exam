#  Exam PG5600

The code has a bug at the image selection screen. Where selection has to happen in sequence.
This is because i used an array to pass data back and forth between views.

The array that holds the selected images for segue is instanciated as empty and because select and deselect methods of the collectionview relies on correct indexes i was not able to remove the correct image from the array out of sequence.

to get around this, a user must select images starting from the top left.

there are no models so the "analysis" is hardcoded. and are only based on the animal recognizer.

when returning to the network selection screen the analysed label in the animal recognizer view is the only one that is updated.

im adding the images used to test with to the project just drag them onto the simulator if they are not there.

tested the ui on iphone 11 and 8 and it worked fine.


