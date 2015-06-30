Rails Interview
===============

This project should take approximately 2 to 5 hours to complete and help Insightpool assess your Rails knowledge and development style. If you find the project takes longer than that please submit a functional version of what you have. We're interested in assessing a functioning project even if all of the business requirements are not implemented.

Business Requirements
---------------------

It's 1993 and you're Dennis Nedry, the lead developer for the new Jurassic Park. The builders and developers need a system to keep track of the different cages around the park and the different dinosaurs in each one. You'll need to develop a JSON formatted RESTful API to allow the builders to create new cages, and add dinosaurs to the cages. It will also allow doctors and scientists the ability to edit/retrieve the statuses of dinosaurs and cages.

* √ Cages must have a maximum capacity for how many dinosaurs it can hold.
* √ Cages know how many dinosaurs are contained.
* √ Cages have a power status of ACTIVE or DOWN.
* √ Cages cannot be powered off if they contain dinosaurs.
* √ Dinosaurs cannot be moved into a cage that is powered down.
* √ Each dinosaur must have a name.
* √ Each dinosaur must have a species (See enumerated list below, feel free to add others).
* √ Each dinosaur is considered an herbivore or a carnivore, depending on its species.
* √ Herbivores cannot be in the same cage as carnivores.
* √ Carnivores can only be in a cage with other dinosaurs of the same species.
* √ Must be able to query a listing of dinosaurs in a specific cage.
* √ When querying dinosaurs or cages they should be filterable on their attributes (Cages on their power status and dinosaurs on species).

All requests should be respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.

Sample Dinosaurs:

**Carnivores:**
* Tyrannosaurus
* Velociraptor
* Spinosaurus
* Megalosaurus

**Herbivores:**
* Brachiosaurus
* Stegosaurus
* Ankylosaurus
* Triceratops

Technical Requirements
----------------------

√ This should be done with rails, rails-api, or sinatra (though we prefer rails/rails-api).

√ Work should be done using version control, preferably git. We would like to see how you use version control.

√ You can assume only one instance of this application will run on a single threaded webserver.

The project should have automated tests that ensure the business logic implemented is correct.

The project should include a readme that addresses anything you may not have completed. It should also address what additional changes you might need to make if the application were intended to run in a concurrent environment. Any other comments or thoughts about the project are also welcome.

Submission Requirements
-----------------------

A link to a hosted git repository or tarball of the git repository of the finished project. Please email the link or tarball to sethen.maleno@insightpool.com
