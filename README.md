# MyApp

The MyApp code is fodder for discussions around coding practices and alternatives.

In its current form it explores how to actually go about implementing LostKobrakai's suggestions at https://elixirforum.com/t/is-there-a-way-to-define-a-filter-where-clause-on-a-schema/66660/2

Instead of using a table each for posts and comments it uses two general purpose tables called bases and links plus an Ecto.Enum discriminator to indicate which rows contain what kind of data.

Nobody in their right mind would actually implement posts and comments this wasteful and convoluted way, but that is not the point. It simply reuses the all familiar chat app nomenclature of users, posts, comments and tags often used in the Phoenix examples to show actual code so we can explore ways of handling things more elegantly.

The original problem is that when using the module name as a Ecto.Queryable the filter to restrict rows to the desired discriminator value has to be added manually each time.

