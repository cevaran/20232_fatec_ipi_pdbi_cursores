DO $$
DECLARE
	--1. Declaração do cursor (unbound (não vinculado))
	cur_delete REFCURSOR;
	tupla RECORD;
BEGIN
	--2. Abertura do cursos 
	--scroll para descer e subir
	OPEN cur_delete SCROLL FOR
		SELECT * FROM tb_top_youtubers;
	LOOP
		--3. Recuperação de dados
			FETCH cur_delete INTO tupla;
			EXIT WHEN NOT FOUND;
			IF tupla.video.count IS NULL THEN
				DELETE FROM 
					tb_top_youtubers
				WHERE CURRENT OF cur_delete;
			END IF; 
	END LOOP;
		
		LOOP
			FETCH BACKWARD FROM cur_delete INTO tupla;
			EXIT WHEN NOT FOUND; 
			RAISE NOTICE '%', tupla;
		END LOOP;
					
END;
$$






-- --nome do youtber e o número de inscritos
-- --concatenando e exibindo apenas no final
-- DO $$
-- DECLARE
-- 	cur_nomes_e_inscritos CURSOR FOR SELECT youtuber, subscribers FROM tb_top_youtubers;
-- 	--um record pode representar uma linha
-- 	--tupla.nome dá acesso ao valor na coluna nome
-- 	tupla RECORD;
-- 	resultado TEXT DEFAULT '';
-- BEGIN
-- 	--2. Abrir o cursor
-- 	OPEN cur_nomes_e_inscritos;
-- 	--3. Recuperação de dados
-- 	FETCH cur_nomes_e_inscritos INTO tupla;
-- 	WHILE FOUND LOOP
-- 		resultado := resultado || tupla.youtuber || ':' || tupla.subscribers || ',';
-- 		FETCH cur_nomes_e_inscritos INTO tupla;		
-- 	END LOOP;
-- 	--4. Fechar o cursor;
-- 	CLOSE cur_nomes_e_inscritos;
-- 	RAISE NOTICE '%', resultado;
-- END;
-- $$



-- -- cursor unbound com query dinânimca
-- -- dinâmica: armazenada como string
-- -- exibir canis que começaram somente a partir
-- -- de um ano específico

--  DO $$
--  DECLARE
--  	cur_nomes_a_partir_de REFCURSOR;
--  	v_youtuber VARCHAR(200);
--  	v_ano INT := 2008;
--  	v_nome_tabela VARCHAR(200) := 'tb_top_youtubers';
--  BEGIN
--  	--2. Abertura do cursor
--  	OPEN cur_nomes_a_partir_de FOR EXECUTE
--  	format
--  	(
--  	'
--  		SELECT youtuber FROM %s WHERE started >= $1
--  	'
--  	,
--  		v_nome_tabela	
--  	) USING v_ano;
--  	LOOP
--  		--3. Recuperação dos dados de interesse
--  		FETCH cur_nomes_a_partir_de INTO v_youtuber;
--  		EXIT WHEN NOT FOUND;
--  		RAISE NOTICE '%', v_youtuber;
--  	END LOOP;
--  	--4. Fechar o cursor
--  	CLOSE cur_nomes_a_partir_de;
--  END;
--  $$



-- --Bloco anonimo de cursor usando uma coluna de uma tabela
--  DO 
--  $$
--  DECLARE
--  	--1.Declaração do cursor
--  	cur_nomes_youtubers REFCURSOR;
--  	-- para armazenar o nome de cada vez
--  	v_youtuber VARCHAR(200);
--  BEGIN
--  	--2.Abertura do cursor
--  	OPEN cur_nomes_youtubers FOR
--  		SELECT youtuber
--  		FROM
--  		tb_top_youtubers;
--  	LOOP
--  		--3. Recuperação dos dados de interesse
--  		FETCH cur_nomes_youtubers INTO v_youtuber;
--  		--variável especial: FOUND -- cada bloco anonimo tem o seu FOUND
--  		EXIT WHEN NOT FOUND;
--  		RAISE NOTICE 'Nome: %', v_youtuber;
--  	END LOOP;
--  	--4. Fechar o cursor
--  	CLOSE cur_nomes_youtubers;
--  END;
--  $$


-- -- SELECT * FROM tb_top_youtubers;

-- -- CREATE TABLE tb_top_youtubers(
-- -- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- -- 	rank INT,
-- -- 	youtuber VARCHAR(200),
-- -- 	subscribers INT,
-- -- 	video_views VARCHAR(200),
-- -- 	video_count INT,
-- -- 	category VARCHAR(200),
-- -- 	started INT
-- -- );