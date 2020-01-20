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

defmodule Iniciar do
    def init(default_opts) do
        IO.puts "starting up Helloplug..."
        default_opts
    end

    def call(conn, _opts) do
        route(conn.path_info, conn)
    end

    def route(["favicon.ico"],conn) do
        conn |> Plug.Conn.send_resp(200, "")
    end

    def route(["token",usuario],conn) do
        #apenas para uso no desenvolvimento, não seria o método final de aquisição de token

        {:ok, token, _claims} = Regevents.Guardian.encode_and_sign(usuario)
        conn |>  Plug.Conn.send_resp(200, token)
    end


    def route(["metodo",metodo],conn) do
        IO.puts metodo
        {:ok, sql_con} =  MyXQL.start_link(username: "teste",password: "senha",hostname: "localhost",database: "bd_artigos")
        json = Plug.Conn.fetch_query_params(conn).query_params["json"]
        IO.puts json
        resp = apply(Regevents,String.to_atom(metodo),[json,sql_con])
        conn |>  Plug.Conn.send_resp(200, resp)
    end

  
    def route(_etc,conn) do
        conn |> Plug.Conn.send_resp(200, "404")
    end

end
