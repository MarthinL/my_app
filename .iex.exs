import Ecto
alias MyApp.Repo
use MyApp.Part
alias MyApp.Core.{Base, Link, Comment, Post, PostComment}
#p1 = %Post{} |> Post.changeset(%{text: "abc"}) |> Repo.insert!()

#c1 = %Comment{} |> Comment.changeset(%{text: "abc sucks"}) |> Repo.insert!()
#c2 = %Comment{} |> Comment.changeset(%{text: "not"}) |> Repo.insert!()
#l1 = build_assoc(p1, :comment_links, %{part: :post_comment, comment_id: c1.id}) |> Repo.insert!
#l2 = build_assoc(p1, :comment_links, %{part: :post_comment, comment_id: c2.id}) |> Repo.insert!
