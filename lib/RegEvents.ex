defmodule Regevents do


    def novo_evento(json,con) do
        params = Jason.decode!(json)
        nome = params["nome"]
        data = params["data"]
        local =  params["local"]
        
        
        MyXQL.query!(con, "INSERT INTO eventos (nome,data,local) VALUES (?,?,?)",[nome,data,local])

    end

    def novo_artigo(json,con) do
        params = Jason.decode!(json)
        titulo = params["titulo"]
        autor = params["autor"]
        evento =  params["evento"]
        texto =  params["texto"]

        MyXQL.query!(con, "INSERT INTO artigos (titulo,autor,eventoID,texto) VALUES (?,?,?,?)",[titulo,autor,evento,texto])

    end

    def ler_artigo(json,con) do
        id = Enum.at(Jason.decode!(json),0)

        sql = MyXQL.query!(con,"SELECT * FROM artigos WHERE id=?",[id])
        resultado = sql_tuple(sql)
        IO.puts Jason.encode!(resultado)

    end

    def artigos_evento(json,con) do
        id = Enum.at(Jason.decode!(json),0)

        sql = MyXQL.query!(con,"SELECT titulo,autor FROM artigos WHERE eventoID=?",[id])
        resultado = sql_tuple(sql)
        IO.puts Jason.encode!(resultado)

    end

    def todos_eventos(_json,con) do
        sql = MyXQL.query!(con,"SELECT eventoID,nome,data, (SELECT COUNT(*) FROM artigos WHERE artigos.eventoID = eventos.eventoID) AS artigos FROM eventos")
        resultado = sql_tuple(sql)
        IO.puts Jason.encode!(resultado)
    end

    def sql_tuple(sql) do
        rows = sql.rows
        columns = sql.columns

        Enum.map rows, fn(row) ->
            Enum.zip(columns, row) |> Map.new
        end
    end

end

defmodule Helloplug do
  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    default_opts
  end

  def call(conn, _opts) do
    IO.puts "saying hello!"
    Plug.Conn.send_resp(conn, 200, "Hello, world!<script>alert('oi')</script>")
  end
end