
{:ok, con} =  MyXQL.start_link(username: "teste",password: "senha",hostname: "localhost",database: "bd_artigos")
#{:ok, token, claims} = Regevents.Guardian.encode_and_sign(1)
{:ok, claims} = Regevents.Guardian.decode_and_verify("eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJyZWdldmVudHMiLCJleHAiOjE1ODE5NzY3NjEsImlhdCI6MTU3OTU1NzU2MSwiaXNzIjoicmVnZXZlbnRzIiwianRpIjoiZTYzMWYyYTktODFmMS00MjFkLTliZDctMTMxMWY3YzkxODQyIiwibmJmIjoxNTc5NTU3NTYwLCJzdWIiOiJhbmRyJUMzJUE5IiwidHlwIjoiYWNjZXNzIn0.5fe3yyXv7GboWN4omF3CCRxkO8z7l2ydRrrhG9xXUw7eGtaGMWM27kCQ4t60fODm6kUWzoldw483CzYk3sMifg")
asdf = "novo_artigo"
#apply(Regevents,String.to_atom(asdf),[System.argv(),con])
IO.puts claims["sub"]
#Regevents.todos_eventos(System.argv(),con)




