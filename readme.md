## Squad Lab

For the long weekend, we'd like you to combine your knowledge of Sinatra + SQL to build an app to create, read, update and delete squads and students in their respective squads.

### Data

You should have two tables, squads and students. Keep this relationship in mind when you build your tables - **One squad has many students**. We are also going to assume that all students are in squads (meaning that there can never be a student who is not part of a squad)

Students should have a/an:

1. Unique ID  
2. Squad ID
1. Name
2. Age
3. Spirit Animal

Each squad should have a:

1. Unique ID
1. Name
2. Mascot

Your students table should have a foreign key that links it to the squads table.

### BEFORE YOU ADD ANY ROUTES OR EVEN A LINE OF RUBY CODE, TEST YOUR DATA IN PSQL AND MAKE SURE YOU CAN SUCCESSFULLY JOIN THE TABLES

-------

### Routes

##### Your app should have the following `GET` routes.

`/` - this is your root route and since there is anothing here, you can simply add this code in your `app.rb` so that it redirects to a route with an erb page.

```
get '/' do
 redirect '/squads'
end 
```

`/squads` - this route should take the user to a page that shows all of the squads

`/squads/new` - this route should take the user to a page with a form that allows them to create a new squad

`/squads/:squad_id` - this route should take the user to a page that shows information about a single squad

`/squads/:squad_id/edit` - this route should take the user to a page with a form that allows them to edit an existing squad

`/squads/:squad_id/students` - this route should take the user to a page that shows all of the students for an individual squad

`/squads/:squad_id/students/:student_id` - this route should take the user to a page that shows information about an individual student in a squad

`/squads/:squad_id/students/new` - this route should take the user to a page that shows all of the squads

`/squads/:squad_id/students/:student_id/edit` - this route should take the user to a page that shows all of the squads

##### Your app should have the following `POST` routes.

`/squads` - this route should used for creating a new squad

`/squads/:squad_id/students` - this route should used for creating a new student in an existing squad

##### Your app should have the following `PUT` routes.

`/squads` - this route should used for editing an existing squad

`/squads/:squad_id/students` - this route should used for editing an existing student in a squad

##### Your app should have the following `DELETE` routes.

`/squads` - this route should used for deleting an existing squad

`/squads/:squad_id/students` - this route should used for editing an existing student in a squad


### Bonus

1. Style your application!
2. Add a column to the students table called `is_squad_leader`, which is a `boolean`. When you list out the students in a squad, their name should be bolded.
2. Use your knowledge of JavaScript and AJAX to make the page more dynamic.
