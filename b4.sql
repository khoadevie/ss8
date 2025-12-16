CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    discount_percent INT
);

INSERT INTO products (name, price, discount_percent) VALUES
('Laptop Dell', 20000000, 20),
('iPhone', 25000000, 60),
('Tai nghe Sony', 3000000, 10);

CREATE OR REPLACE PROCEDURE calculate_discount(
    p_id INT,
    OUT p_final_price NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_price NUMERIC;
    v_discount INT;
BEGIN
    SELECT price, discount_percent
    INTO v_price, v_discount
    FROM products
    WHERE id = p_id;

    IF v_price IS NULL THEN
        RAISE EXCEPTION 'Product not found';
    END IF;

    IF v_discount > 50 THEN
        v_discount := 50;
    END IF;

    p_final_price := v_price - (v_price * v_discount / 100);

    UPDATE products
    SET price = p_final_price
    WHERE id = p_id;
END;
$$;

CALL calculate_discount(2, NULL);
