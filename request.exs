
{:ok, con} =  MyXQL.start_link(username: "teste",password: "senha",hostname: "localhost",database: "bd_artigos")
#{:ok, token, claims} = Regevents.Guardian.encode_and_sign(1)
asdf = "artigos_evento"
apply(Regevents,String.to_atom(asdf),["[2]",con])

#Regevents.todos_eventos(System.argv(),con)




