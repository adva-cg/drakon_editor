-- Autogenerated with DRAKON Editor 1.32
local tt = {}
tt.number = "number"
tt.operator = "operator"
tt.identifier = "identifier"

local lex = {}
lex.initialized = false


function add_char(data, c)
    -- item 348
    table.insert(data.current, c)
end

function array_to_string(chars)
    local result
    -- item 366
    result = ""
    for i, char in pairs(chars) do
        -- item 367
        result = result .. string.char(char)
    end
    -- item 368
    return result
end

function baby_frog_Hungry_food(self, msg)
    local message
    -- item 448
    message = "yam-yam"
    -- item 424
    self.state = "Sleepy"
    return message
end

function baby_frog_Hungry_sleep(self, msg)
    -- item 433
    self.state = "Hungry"
    return "I am hungry"
end

function baby_frog_Sleepy_food(self, msg)
    -- item 435
    self.state = "Sleepy"
    return "na..."
end

function baby_frog_Sleepy_sleep(self, msg)
    -- item 439
    self.state = "Hungry"
    return "z-z-z..."
end

function create_identifier(data)
    -- item 126
    create_token(data, tt.identifier)
end

function create_number(data)
    -- item 237
    create_token(data, tt.number)
end

function create_operator(data)
    -- item 239
    create_token(data, tt.operator)
end

function create_token(data, type)
    local text, token
    -- item 132
    if #data.current == 0 then
        
    else
        -- item 349
        text = data.current
        data.current = {}
        -- item 350
        token = token_create(type, text)
        table.insert(data.tokens, token)
    end
end

function define_op_char(text)
    local code
    -- item 408
    code = string.byte(text)
    -- item 407
    lex.op_chars[code] = true
end

function define_space(text)
    local code
    -- item 415
    code = string.byte(text)
    -- item 414
    lex.whitespace[code] = true
end

function is_digit(c)
    -- item 301
    if (c >= lex.zero) and (c <= lex.nine) then
        -- item 309
        return true
    else
        -- item 310
        return false
    end
end

function is_long_op(first, second)
    for i, long_op in pairs(lex.long_ops) do
        -- item 251
        if (string.byte(long_op, 1) == first) and (string.byte(long_op, 2) == second) then
            -- item 257
            return true
        else
            
        end
    end
    -- item 258
    return false
end

function is_operator(c)
    -- item 194
    if lex.op_chars[c] == true then
        -- item 197
        return true
    else
        -- item 193
        return false
    end
end

function is_space(c)
    -- item 398
    if lex.whitespace[c] == true then
        -- item 401
        return true
    else
        -- item 397
        return false
    end
end

function lex.init()
    local i
    -- item 266
    if lex.initialized then
        
    else
        -- item 265
        lex.op_chars = {}
        lex.long_ops = {"==", "!=", "<=", ">="}
        lex.initialized = true
        lex.whitespace = {}
        -- item 2780001
        i = 1
        while true do
            -- item 2780002
            if i <= 256 then
                
            else
                break
            end
            -- item 280
            lex.op_chars[i] = false
            -- item 2780003
            i = i + 1
        end
        -- item 391
        define_space(" ")
        define_space("\t")
        define_space("\r")
        define_space("\n")
        -- item 269
        define_op_char("!")
        define_op_char("=")
        define_op_char("<")
        define_op_char(">")
        define_op_char("-")
        define_op_char("+")
        define_op_char("/")
        define_op_char("\\")
        define_op_char("*")
        define_op_char("%")
        define_op_char("(")
        define_op_char(")")
        define_op_char("(")
        define_op_char(")")
        define_op_char("{")
        define_op_char("}")
        define_op_char(":")
        define_op_char(".")
        define_op_char("#")
        define_op_char(",")
        define_op_char("^")
        define_op_char("|")
        define_op_char("&")
        define_op_char("'")
        define_op_char("\"")
        -- item 351
        lex.zero = string.byte("0")
        lex.nine = string.byte("9")
        lex.a = string.byte("a")
        lex.z = string.byte("z")
        lex.ca = string.byte("A")
        lex.cz = string.byte("Z")
        lex.under = string.byte("_")
        lex.space = string.byte(" ")
    end
end

function lexer_machine_identifier_digit(self, data, c)
    -- item 60
    add_char(data, c)
    -- item 63
    self.state = "identifier"
end

function lexer_machine_identifier_letter(self, data, c)
    -- item 59
    add_char(data, c)
    -- item 62
    self.state = "identifier"
end

function lexer_machine_identifier_operator(self, data, c)
    -- item 276
    create_identifier(data)
    -- item 61
    add_char(data, c)
    -- item 64
    self.state = "operator"
end

function lexer_machine_identifier_whitespace(self, data, c)
    -- item 65
    create_identifier(data)
    -- item 31
    self.state = "idle"
end

function lexer_machine_idle_default(self, data, c)
    -- item 23
    self.state = "idle"
end

function lexer_machine_idle_digit(self, data, c)
    -- item 45
    add_char(data, c)
    -- item 48
    self.state = "number"
end

function lexer_machine_idle_letter(self, data, c)
    -- item 44
    add_char(data, c)
    -- item 47
    self.state = "identifier"
end

function lexer_machine_idle_operator(self, data, c)
    -- item 46
    add_char(data, c)
    -- item 49
    self.state = "operator"
end

function lexer_machine_number_digit(self, data, c)
    -- item 77
    add_char(data, c)
    -- item 80
    self.state = "number"
end

function lexer_machine_number_dummy(self, data, c)
    -- item 81
    self.state = "operator"
end

function lexer_machine_number_letter(self, data, c)
    -- item 76
    add_char(data, c)
    -- item 79
    self.state = "number"
end

function lexer_machine_number_operator(self, data, c)
    -- item 83
    create_number(data)
    -- item 78
    add_char(data, c)
    -- item 81
    self.state = "operator"
end

function lexer_machine_number_whitespace(self, data, c)
    -- item 82
    create_number(data)
    -- item 34
    self.state = "idle"
end

function lexer_machine_operator_digit(self, data, c)
    -- item 101
    create_operator(data)
    -- item 94
    add_char(data, c)
    -- item 97
    self.state = "number"
end

function lexer_machine_operator_letter(self, data, c)
    -- item 100
    create_operator(data)
    -- item 93
    add_char(data, c)
    -- item 96
    self.state = "identifier"
end

function lexer_machine_operator_operator(self, data, c)
    -- item 103
    if try_make_long_op(data, c) then
        -- item 106
        self.state = "idle"
    else
        -- item 107
        create_operator(data)
        -- item 95
        add_char(data, c)
        -- item 98
        self.state = "operator"
    end
end

function lexer_machine_operator_whitespace(self, data, c)
    -- item 99
    create_operator(data)
    -- item 26
    self.state = "idle"
end

function main()
    local frog, text, tokens
    -- item 346
    lex.init()
    -- item 161
    text = "foo.Bar(34 / 4-(18+m * 3)) ==800"
    tokens = tokenize(text)
    -- item 207
    print("  Text:\n" .. text)
    print("  Tokens:")
    for i, token in pairs(tokens) do
        -- item 206
        token_print(token)
    end
    -- item 446
    frog = baby_frog()
    -- item 447
    print("The baby frog says:")
    print(frog.state .. "/sleep")
    print(frog:sleep())
    print(frog.state .. "/food")
    print(frog:food())
    print(frog.state .. "/food")
    print(frog:food())
    print(frog.state .. "/sleep")
    print(frog:sleep())
end

function token_create(type, chars)
    local token
    -- item 353
    token = {
        type = type,
        text = array_to_string(chars)
    }
    -- item 354
    return token
end

function token_print(token)
    local message
    -- item 333
    message = token.type .. ": " .. token.text
    -- item 355
    print(message)
end

function tokenize(text)
    local c, data, lexer
    local i
    -- item 315
    data = {
        current = {},
        tokens = {}
    }
    -- item 167
    lexer = lexer_machine()
    -- item 1680001
    i = 1
    while true do
        -- item 1680002
        if i <= string.len(text) then
            
        else
            break
        end
        -- item 319
        c = string.byte(text, i)
        -- item 172
        if is_space(c) then
            -- item 356
            lexer:whitespace(data, lex.space)
        else
            -- item 178
            if is_digit(c) then
                -- item 312
                lexer:digit(data, c)
            else
                -- item 183
                if is_operator(c) then
                    -- item 313
                    lexer:operator(data, c)
                else
                    -- item 181
                    lexer:letter(data, c)
                end
            end
        end
        -- item 1680003
        i = i + 1
    end
    -- item 358
    lexer:whitespace(data, lex.space)
    -- item 170
    return data.tokens
end

function try_make_long_op(data, c)
    local previous, text, token
    -- item 154
    previous = data.current[1]
    -- item 155
    if is_long_op(previous, c) then
        -- item 158
        data.current = {}
        text = { previous, c }
        token = token_create(tt.operator, text)
        table.insert(data.tokens, token)
        -- item 159
        return true
    else
        -- item 160
        return false
    end
end


function lexer_machine()
    local obj = {}
    obj.type_name = "lexer_machine"
    obj.state = "idle"
    obj.digit = function(self, data, c)
        local _state_ = self.state
        if _state_ == "idle" then
            return lexer_machine_idle_digit(self, data, c)
        elseif _state_ == "identifier" then
            return lexer_machine_identifier_digit(self, data, c)
        elseif _state_ == "number" then
            return lexer_machine_number_digit(self, data, c)
        elseif _state_ == "operator" then
            return lexer_machine_operator_digit(self, data, c)
        end
        return nil
    end
    obj.dummy = function(self, data, c)
        local _state_ = self.state
        if _state_ == "idle" then
            return lexer_machine_idle_default(self, data, c)
        elseif _state_ == "number" then
            return lexer_machine_number_dummy(self, data, c)
        end
        return nil
    end
    obj.letter = function(self, data, c)
        local _state_ = self.state
        if _state_ == "idle" then
            return lexer_machine_idle_letter(self, data, c)
        elseif _state_ == "identifier" then
            return lexer_machine_identifier_letter(self, data, c)
        elseif _state_ == "number" then
            return lexer_machine_number_letter(self, data, c)
        elseif _state_ == "operator" then
            return lexer_machine_operator_letter(self, data, c)
        end
        return nil
    end
    obj.operator = function(self, data, c)
        local _state_ = self.state
        if _state_ == "idle" then
            return lexer_machine_idle_operator(self, data, c)
        elseif _state_ == "identifier" then
            return lexer_machine_identifier_operator(self, data, c)
        elseif _state_ == "number" then
            return lexer_machine_number_operator(self, data, c)
        elseif _state_ == "operator" then
            return lexer_machine_operator_operator(self, data, c)
        end
        return nil
    end
    obj.whitespace = function(self, data, c)
        local _state_ = self.state
        if _state_ == "idle" then
            return lexer_machine_idle_default(self, data, c)
        elseif _state_ == "identifier" then
            return lexer_machine_identifier_whitespace(self, data, c)
        elseif _state_ == "number" then
            return lexer_machine_number_whitespace(self, data, c)
        elseif _state_ == "operator" then
            return lexer_machine_operator_whitespace(self, data, c)
        end
        return nil
    end
    return obj
end

function baby_frog()
    local obj = {}
    obj.type_name = "baby_frog"
    obj.state = "Hungry"
    obj.food = function(self, msg)
        local _state_ = self.state
        if _state_ == "Hungry" then
            return baby_frog_Hungry_food(self, msg)
        elseif _state_ == "Sleepy" then
            return baby_frog_Sleepy_food(self, msg)
        end
        return nil
    end
    obj.sleep = function(self, msg)
        local _state_ = self.state
        if _state_ == "Hungry" then
            return baby_frog_Hungry_sleep(self, msg)
        elseif _state_ == "Sleepy" then
            return baby_frog_Sleepy_sleep(self, msg)
        end
        return nil
    end
    return obj
end

main()
