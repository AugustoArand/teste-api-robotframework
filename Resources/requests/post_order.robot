*** Settings ***
Library     RequestsLibrary
Library     FakerLibrary
Library     JSONLibrary
Library     Collections
Resource    ../session/order_session.robot


*** Variables ***
${env}      ${EMPTY}


*** Keywords ***
request.post.orders
    [Arguments]
    ...    ${order_id}
    ...    ${status}
    ...    ${items_product}
    ...    ${items_quantity}
    ...    ${items_price}
    ...    ${status_code}
    ...    ${customer_name}=${user_data.${env}.user_name}
    ...    ${customer_email}=${user_data.${env}.user_email}
    ...    ${shipping_address}=${True}

    IF    ${shipping_address}
        ${shipping_address_street}    FakerLibrary.Street Address
        ${shipping_address_city}    FakerLibrary.City
        ${shipping_address_zipcode}    FakerLibrary.Postcode
    ELSE
        ${shipping_address_street}    Set Variable    ${EMPTY}
        ${shipping_address_city}    Set Variable    ${EMPTY}
        ${shipping_address_zipcode}    Set Variable    ${EMPTY}
    END

    ${items}    ${total_price}    items.list
    ...    product=${items_product}
    ...    quantity=${items_quantity}
    ...    price=${items_price}

    ${body}    body.post.orders
    ...    order_id=${order_id}
    ...    total_price=${total_price}
    ...    status=${status}
    ...    customer_name=${customer_name}
    ...    customer_email=${customer_email}
    ...    items=${items}
    ...    street=${shipping_address_street}
    ...    city=${shipping_address_city}
    ...    zipcode=${shipping_address_zipcode}

    Set Test Variable    ${body}

    ${alias}    session.orders

    ${response}    POST On Session
    ...    alias=${alias}
    ...    url=/posts
    ...    json=${body}
    ...    expected_status=${status_code}
    ...    msg=Falha ao criar pedida de venda
    RETURN    ${response}

items.list
    [Arguments]
    ...    ${product}
    ...    ${quantity}
    ...    ${price}

    ${items}    Load Json From File    ${CURDIR}${/}json${/}items_list.json
    ${items_list}    Create List

    FOR    ${l1-product}    ${l2-quantity}    ${l3-price}    IN ZIP    ${product}    ${quantity}    ${price}
        ${items}    Update Value To Json    ${items}    $.product    ${l1-product}
        ${items}    Update Value To Json    ${items}    $.quantity    ${l2-quantity}
        ${items}    Update Value To Json    ${items}    $.price    ${l3-price}

        Append To List    ${items_list}    ${items}
    END

    ${total_price}    Evaluate    sum(int(item['quantity']) * int(item['price']) for item in ${items_list})
    RETURN
    ...    ${items_list}
    ...    ${total_price}

body.post.orders
    [Arguments]
    ...    ${order_id}
    ...    ${total_price}
    ...    ${status}
    ...    ${customer_name}
    ...    ${customer_email}
    ...    ${items}
    ...    ${street}
    ...    ${city}
    ...    ${zipcode}

    ${body}    Load Json From File    ${CURDIR}${/}json${/}post_order.json

    ${body}    Update Value To Json    ${body}    $.order.order_id    ${order_id}
    ${body}    Update Value To Json    ${body}    $.order.total_price    ${total_price}
    ${body}    Update Value To Json    ${body}    $.order.status    ${status}
    ${body}    Update Value To Json    ${body}    $.order.customer.name    ${customer_name}
    ${body}    Update Value To Json    ${body}    $.order.customer.email    ${customer_email}
    ${body}    Update Value To Json    ${body}    $.order.items    ${items}
    ${body}    Update Value To Json    ${body}    $.order.shipping_address.street    ${street}
    ${body}    Update Value To Json    ${body}    $.order.shipping_address.city    ${city}
    ${body}    Update Value To Json    ${body}    $.order.shipping_address.zipcode    ${zipcode}
    RETURN
    ...    ${body}
