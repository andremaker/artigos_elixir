defmodule Regevents do


    def novo_evento(json,con) do
        params = Jason.decode!(json)
        nome = params["nome"]
        data = params["data"]
        local =  params["local"]
        
        case Regevents.Guardian.decode_and_verify(params["token"]) do
            {:ok, _} -> 
                MyXQL.query!(con, "INSERT INTO eventos (nome,data,local) VALUES (?,?,?)",[nome,data,local])
                "Inseriddo com sucesso"
            {:error, _} -> "falha na autenticacao"
        end

    end

    def novo_artigo(json,con) do
        params = Jason.decode!(json)
        titulo = params["titulo"]
        autor = params["autor"]
        evento =  params["eventoID"]
        texto =  params["texto"]


        

        case Regevents.Guardian.decode_and_verify(params["token"]) do
            {:ok, _} -> 
                MyXQL.query!(con, "INSERT INTO artigos (titulo,autor,eventoID,texto) VALUES (?,?,?,?)",[titulo,autor,evento,texto])
                "Inserido com sucesso"
            {:error, _} -> "falha na autenticacao"
        end


        
    end

    def ler_artigo(json,con) do
        id = Enum.at(Jason.decode!(json),0)

        sql = MyXQL.query!(con,"SELECT * FROM artigos WHERE id=?",[id])
        resultado = sql_tuple(sql)
        Jason.encode!(resultado)

    end

    def artigos_evento(json,con) do
        id = Enum.at(Jason.decode!(json),0)

        sql = MyXQL.query!(con,"SELECT titulo,autor FROM artigos WHERE eventoID=?",[id])
        resultado = sql_tuple(sql)
        Jason.encode!(resultado)

    end

    def todos_eventos(_json,con) do
        sql = MyXQL.query!(con,"SELECT eventoID,nome,data, (SELECT COUNT(*) FROM artigos WHERE artigos.eventoID = eventos.eventoID) AS artigos FROM eventos")
        resultado = sql_tuple(sql)
        Jason.encode!(resultado)
    end

    def sql_tuple(sql) do
        rows = sql.rows
        columns = sql.columns

        Enum.map rows, fn(row) ->
            Enum.zip(columns, row) |> Map.new
        end
    end

end
