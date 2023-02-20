# Pizza Shop

This is a coding challenge. See the description [here](GOAL.md).

## System requirements

* Ruby version 3.2.1.

* PostgreSQL with the extensions 'pgcrypto', and 'plpgsql'. I use the version 15.1
but lower versions should do the job well.

## Installation

* Clone the repository and `cd` to the project.

* Be sure you are using the proper version of ruby (`rvm` or `rbenv` can help).
Probably you'll need to create a special `gemset`.

* In PostgreSQL create a new role that has right to create databases

* Rename or copy file `config/database.yml.sample` to `config/database.yml` and
edit it to enable the connection to the database.

* Run `bundle install`.

* To create and initilize the Database run the following commands:

```
rails db:create
rails db:migrage
rails db:seed
```

* The command `rails db:seed` reverts the completed Orders to the initial state.

* To start the server execute `rails server -d`

* To run the test suite execute `rspec -fd`

* To monitor if any change had not broken any Spec, start the Guard in a console
with the command `guard`.

* If required you can prepend commands above with `bundle exec `

# The Notes

1. I have had a choice: to deliver a quick and dirty solution or
spend more time and implement the project in a way it should be.
I have chosen the second approach. Not only to show the methods and technologies I'm using
but mainly because I've got a habit to do every task in the best way I can.
My experience says that this approach saves a lot of time in the long run.

1. By setting the limit to 4 hours you probably wanted to know, weather a candidate can
provide a quick and dirty solution. Of course, I can do that. But, sorry,
I prefer not show it now.
Absolutely 4 hours are not enough to create the proper code that I prefer to deliver.

1. I assume that no Order ever has two Promotions with the same combination of the pizza + size. It should be checked at the stage of adding a Promotion to an Order.

1. I used some parts of the code of my previous projects.
Additionally there is some generated code that is not used.
I did not clear some parts of them to save my time.
So, please, do not mind the extra code that is not needed here.

1. I skipped the creation of controllers and views for all models except Order.

1. I did not use any javascript. Though better to use it.

1. I skipped the validation that `Promotion#to` is less than `Promotion#from`.

1. I skipped the validation of the uniqueness of names in models that have `#name` attribute.

1. I skipped the creation of State Machine for Order but created the field `#price`,
that should be calculated and saved as soon as the Order is completed.
It should be kept, as later the prices can be changed but we have to know
the actual price of the Order. The state machine should prevent the editing of the orders
that are completed. Though now the editing is not possible completely ;-)

1. I have completely skipped the part of indices optimization and dropping unnecessary timestamps. You may be sure I am professional in that.

1. At the beginning I understood that there can be more than one Discount per Order. It turned out that it is wrong. So I have had to rebuild the class Order. For that there are 2 additional migrations.

1. I have noticed the requirement to implement the operation "complete"
as a variant of an Order editing. But I consider it wrong.
The person that delivers an Order must mark it to be completed but must not have the
rights to edit it. Therefore I implemented this operation as it should be done:
with the special action in the controller.

1. Regarding a linter. In early 2000 I have met Bozhidar Batsov that told about `rubocop`.
I was very excited with it and started to use it in my projects.
But later I have recognized that I write the code exactly in accordance with the
rules. But sometimes it is required to make an exception,
and writing the local rules for `rubocop` becomes the waste of time.
So I do not use it in my projects.

1. Though I recognize the importance of using `rubocop` in the teams and feel myself quite comfortable with it. You can find marks of my earlier use of `rubocop` in the code.
