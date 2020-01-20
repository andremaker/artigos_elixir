
{:ok, con} =  MyXQL.start_link(username: "teste",password: "senha",hostname: "localhost",database: "bd_artigos")
#{:ok, token, claims} = Regevents.Guardian.encode_and_sign(1)
asdf = "novo_artigo"
apply(Regevents,String.to_atom(asdf),[System.argv(),con])

#Regevents.todos_eventos(System.argv(),con)




