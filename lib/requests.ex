
defmodule Iniciar do
    def init(default_opts) do
        IO.puts "starting up Helloplug..."
        default_opts
    end

    def call(conn, _opts) do
        route(conn.method, conn.path_info, conn)
    end

    def route(_, ["favicon.ico"],conn) do
        conn |> Plug.Conn.send_resp(200, "")
    end

    def route(_,["teste"],conn) do
        conn |> Plug.Conn.put_resp_content_type("text/html") |> Plug.Conn.send_resp(200,"
        json: <input id='json' type='text'> <br>
        metodo: <input id='metodo' type='text' value='ler_artigo'><br>
        <button onclick='request()'>Enviar</button><br>
        resposta: <a id='resp'></a>

        <script>
            
            function request(){
                var request = new XMLHttpRequest();

                request.open('POST','http://localhost:4000/metodo/'+metodo.value, true);
                request.setRequestHeader('Content-Type', 'application/json');
                
                request.onreadystatechange = function() {
                        if (this.readyState == 4 && this.status == 200) {
                            resp.innerText = this.responseText
                        }
                    };
                request.send(json.value);
            }


        </script>")
    end

    def route(_,["token",usuario],conn) do
        #apenas para uso no desenvolvimento, não seria o método final de aquisição de token

        {:ok, token, _claims} = Regevents.Guardian.encode_and_sign(usuario)
        conn |>  Plug.Conn.send_resp(200, token)
    end



    def route("POST",["metodo",metodo],conn) do
        IO.puts metodo
        {:ok, sql_con} =  MyXQL.start_link(username: "teste",password: "senha",hostname: "localhost",database: "bd_artigos")
        {:ok,json,_} = Plug.Conn.read_body(conn)
        IO.puts json
        resp = apply(Regevents,String.to_atom(metodo),[json,sql_con])
        conn |>  Plug.Conn.send_resp(200, resp)
    end

    def route("GET",["metodo",metodo],conn) do
        IO.puts metodo
        {:ok, sql_con} =  MyXQL.start_link(username: "teste",password: "senha",hostname: "localhost",database: "bd_artigos")
        json = Plug.Conn.fetch_query_params(conn).query_params["json"]
        IO.puts json
        resp = apply(Regevents,String.to_atom(metodo),[json,sql_con])
        conn |>  Plug.Conn.send_resp(200, resp)
    end

  
    def route(_,_,conn) do
        conn |> Plug.Conn.send_resp(200, "404")
    end

end
