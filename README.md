# Funkadactyl
## About
This represents my work at about the 4 hour mark using a timer to time out a great number of spread out sessions due to some unfortunate scheduling on my part where I lacked day-time hours to work on it.

### The API
Everything should be pretty straight forward and should be covered by looking over the tests in the spec/apis folder. The example species are covered in the seeds, but since new species are discovered every day, they are a model and not an enum or dictionary on the dino model. 

I went with AASM to handle the state machine for the cage. It's just two states and is real simple. I regret not refactoring the state list to be an enum, but it's really not bad as is. To power off a cage, send a GET to /cages/:id/power_down it will check and see it it's possible and return and error or a status. I debated on whether GET or PUT was appropriate here since you aren't sending any data but are affecting change. 

## Changes Needed
The project is, first and foremost, very insecure. Token-based authentication would need to be added pretty quickly if anyone were to actually publish this anywhere as an API. 

The project also needs to be refactored to be a versioned API for ease of use. I began moedling it after the last project I worked on that used a versioned API but once I mapped out the app, decided that would be overly complex for such a simple thing—especially one lacking any real users or future updates.

I tend to hammer things out and want to go back for a refactor and commenting as needed. I didn't get there on this project and the result had my pre-Git-push RuboCop run not very happy. 

As a super simple project, it could probably run pretty fast as is, but adding in support for ActiveJob would make it perform way better at scale.

The tests cover the logic but I'm bummed about leaving out straight-up model and controller tests. Instead opting to cover model logic and controllers using api/request/integration-style tests. But, it really ended up working out for me time-wise and I'm far happier with this than just model tests.

## Assignment
### Business Requirements

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

√ All requests should be respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.

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

√ The project should have automated tests that ensure the business logic implemented is correct.

√ The project should include a readme that addresses anything you may not have completed. It should also address what additional changes you might need to make if the application were intended to run in a concurrent environment. Any other comments or thoughts about the project are also welcome.
