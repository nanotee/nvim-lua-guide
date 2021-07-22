# Primeros pasos usando Lua en Neovim

## Introducción

La [integración de Lua](https://www.youtube.com/watch?v=IP3J56sKtn0) como [lenguaje de primera clase 
dentro de Neovim](https://github.com/neovim/neovim/wiki/FAQ#why-embed-lua-instead-of-x) se perfila como una de sus características más destacadas. Sin embargo, la cantidad 
de material didactico para aprender a escribir plugins en Lua no es tan grande como la que se puede 
encontrar para escribirlos en Vimscript. Esta guia es un intento de proveer información básica a 
las personas para que puedan empezar.

Esta guia asume que tu estás unando, al menos, la version 0.5 de Neovim.

### Aprendiendo Lua.

Si tu no estas familiarizado con este lenguaje, hay un varios recursos para empezar:

- [Aprende X en Y minutes, una pagina sobre Lua](https://learnxinyminutes.com/docs/lua/) debería darte una vision general de los conceptos básicos.
- [Esta guia](https://github.com/medwatt/Notes/blob/main/Lua/Lua_Quick_Guide.ipynb) tambien es un buen recurso para empezar rapidamente
- Si aprender mediante videos es más de tu agrado, Derek Banas tiene un [tutorial de
  1-hora sobre el lenguaje](https://www.youtube.com/watch?v=iMacxZQMPXs)
- ¿Deseas algo más interactivo con ejemplos ejecutables? intenta [The LuaScript tutorial](https://www.luascript.dev/learn)
- La [lua-users wiki](http://lua-users.org/wiki/LuaDirectory) está llena de información de todo tipo referente a topicos de Lua.
- La [official reference manual for Lua](https://www.lua.org/manual/5.1/) debería darte el tourt más amigable sobre este lenguaje 
  (existe como Vicdoc plugin si quiere leerlo desde la comodidad de tu editor: [wsdjeg/luarefvim](https://github.com/wsdjeg/luarefvim))


También hay que destacar que Lua es un lenguaje muy limpio y sencillo. Es fácil de aprender, 
especialmente si tienes experiencia con lenguajes de scripting similares como JavaScript. 
Es posible que ya conozcas Lua, mucho más de lo que crees!


Nota: La versión de Lua que Neovim incorpora es [LuaJIT 2.1.0](https://staff.fnwi.uva.nl/h.vandermeer/docs/lua/luajit/luajit_intro.html), que se mantiene la compatibilidad
con Lua 5.1


### Tutoriales existentes para escribir Lua en Neovim

Ya se han escrito algunos tutoriales para ayudar a la gente a escribir plugins en Lua. Algunos de 
ellos han ayudado muchisimo a la hora de escribir esta guía. Muchas gracias a sus autores.


- [teukka.tech - From init.vim to init.lua](https://teukka.tech/luanvim.html)
- [dev.to - How to write neovim plugins in Lua](https://dev.to/2nit/how-to-write-neovim-plugins-in-lua-5cca)
- [dev.to - How to make UI for neovim plugins in Lua](https://dev.to/2nit/how-to-make-ui-for-neovim-plugins-in-lua-3b6e)
- [ms-jpq - Neovim Async Tutorial](https://github.com/ms-jpq/neovim-async-tutorial)
- [oroques.dev - Neovim 0.5 features and the switch to init.lua](https://oroques.dev/notes/neovim-init/)


Plugins complementarios

- [Vimpeccable - Plugin to help write your .vimrc in Lua](https://github.com/svermeulen/vimpeccable)
- [plenary.nvim - All the lua functions I don't want to write twice](https://github.com/nvim-lua/plenary.nvim)
- [popup.nvim - An implementation of the Popup API from vim in Neovim](https://github.com/nvim-lua/popup.nvim)
- [nvim_utils](https://github.com/norcalli/nvim_utils)
- [nvim-luadev - REPL/debug console for nvim lua plugins](https://github.com/bfredl/nvim-luadev) 
- [nvim-luapad - Interactive real time neovim scratchpad for embedded lua engine](https://github.com/rafcamlet/nvim-luapad)
- [nlua.nvim - Lua Development for Neovim](https://github.com/tjdevries/nlua.nvim)
- [BetterLua.vim - Better Lua syntax highlighting in Vim/NeoVim](https://github.com/euclidianAce/BetterLua.vim) 


## Donde ubicar los archivos de Lua
-----------------------------------------------------------------------------------
### init.lua


Neovim permite la carga de un archivo `init.lua` para la configuración, en lugar del habitual `init.vim`.

Nota: `init.lua ` es, por supuesto, *completamente* opcional. El soporte para `init.vim` no va a desaparecer 
y sigue siendo una opción válida para la configuración. Ten en cuenta que algunas características
no están 100% soportadas por Lua todavía.

También ve:
- `:help config`

### Modulos

Los modulos de Lua se encuentran dentro de la carpeta `Lua/` en tu `'runtimepath'` (para la mayoria 
de usuarios, esto significa `~/.config/nvim/lua` en sistemas \*nix y `~/AppData/Local/nvim/lua` en Windows). 
Los paquetes globales `package.path` y `package.cpath` se ajustan automáticamente para incluir los archivos 
Lua en esta carpeta. Esto significa que pueda que debas hacer un `require()` en estos archivos como
modulos de Lua.

Tomemos como ejemplo esta estructura de carpetas:

```text
📂 ~/.config/nvim
├── 📁 after
├── 📁 ftplugin
├── 📂 lua
│  ├── 🌑 myluamodule.lua
│  └── 📂 other_modules
│     ├── 🌑 anothermodule.lua
│     └── 🌑 init.lua
├── 📁 pack
├── 📁 plugin
├── 📁 syntax
└── 🇻 init.vim
```
El siguiente código de Lua cargará `myluamodule.lua`:

```lua
require('myluamodule')
```

Date cuenta la ausencia de la extension `.lua`.

Así mismo, cargar `other_modules/anothermodule.lua` se hace así:

```lua
require('other_modules.anothermodule')
-- or
require('other_modules/anothermodule')
```

Los separadores de ruta se indican con un punto `.` o con un slash `/`.

Una carpeta que contiene un archivo `init.lua` puede ser requerida directamente, sin tener que especificar
el nombre del archivo.

```lua
require('other_modules') -- loads other_modules/init.lua
```


Requerir un módulo inexistente o un módulo que contenga errores de sintaxis aborta el script que se está 
ejecutando. Se puede utilizar `pcall()` para evitar errores.

```lua
local ok, _ = pcall(require, 'module_with_error')
if not ok then
  -- not loaded
end
```

También ve:
- `:help lua-require`


#### Tips

Varios plugins de Lua pueden tener nombres de archivo idénticos en su carpeta `lua/`. Esto podría 
conducir a conflictos de espacio de nombres.

Si dos plugins diferentes tienen un archivo `lua/main.lua`, entonces hacer `require('main')` es incierto: 
¿qué archivo queremos obtener?


Podría ser una buena idea para el espaciar los nombres de tu configuración o tu plugin con una carpeta 
de nivel superior, así: `lua/nombre_del_plugin/main.lua`


### Archivos de ejecución

Al igual que los archivos Vimscript, los archivos Lua pueden cargarse automáticamente desde carpetas 
especiales en tu `runtimepath`. Actualmente, se admiten las siguientes carpetas:

- `colors/`
- `compiler/`
- `ftplugin/`
- `ftdetect/`
- `indent/`
- `plugin/`
- `syntax/`

Nota: en un directorio de ejecución, todos los archivos `*.vim` se proceden o se originan antes que 
los archivos `*.lua`.


También ve:
- `:help 'runtimepath'`
- `:help load-plugins`

#### Tips

Dado que los archivos en tiempo de ejecución no se basan en el sistema de módulos de Lua, dos 
plugins pueden tener un archivo `plugin/main.lua` sin que ello suponga un problema.

## Uusando Lua desde Vimscript

### :lua

Este comando ejecutará un trozo de código Lua.

```vim
:lua require('myluamodule')
```

Multi-line scripts are possible using heredoc syntax:
Scripts multilinea son posibles usando la sintaxis de heredoc.

```vim
echo "Here's a bigger chunk of Lua code"

lua << EOF
local mod = require('mymodule')
local tbl = {1, 2, 3}

for k, v in ipairs(tbl) do
    mod.method(v)
end

print(tbl)
EOF
```

Nota: cada comando `:lua` tiene su propio alcance y las variables declaradas con la palabra clave `local` 
no son accesibles fuera del comando. Esto no funcionará:

```vim
:lua local foo = 1
:lua print(foo)
" prints 'nil' instead of '1'
```

Nota 2: la función `print()` en Lua se comporta de forma similar al comando `:echomsg`. Su salida se 
guarda en el historial de mensajes y puede ser suprimida por el comando `:silent`.

También ve:
- `:help :lua`
- `:help :lua-heredoc`

### :luado

Este comando ejecuta un trozo de código Lua que actúa sobre un rango de líneas en el buffer actual. 
Si no se especifica ningún rango, se utiliza todo el buffer. El string que se `retornado` del fragmento 
que se utiliza para determinar con qué debe reemplazarse cada línea.

El siguiente comando reemplazaría cada línea del buffer actual con el texto "hello world":

```vim
:luado return 'hello world'
```

También se proporcionan dos variables implícitas `line` y `linenr`. `line` es el texto de la 
línea sobre la que se está iterando mientras que `linenr` es su número. El siguiente comando 
hará que todas las líneas cuyo número sea divisible por 2 sean mayúsculas:

```vim
:luado if linenr % 2 == 0 then return line:upper() end
```

También ve:

- `:help :luado`

### Ejecutar archivos Lua

- `:luafile`
- `:source`
- `:runtime`

`:luafile` y `:source` son muy similares:

```vim
:luafile ~/foo/bar/baz/myluafile.lua
:luafile %
:source ~/foo/bar/baz/myluafile.lua
:source %
```
`:source` tambien soporta rangos, que tambien pueden ser utiles para solo ejecutar una parte de 
un script:

```vim
:1,10source
```

`:runtime` es un poco diferente: utiliza la opción `'runtimepath'` para determinar 
los archivos que se deben ejecutar. Ver `:help :runtime` para más detalles

También ve:

- `:help :luafile`
- `:help :source`
- `:help :runtime`


#### Ejecutando archivos lua VS llamar con require():

Puede que te preguntes cuál es la diferencia entre llamar a la función 
`require()` y ejecutar un archivo Lua y si deberías preferir una forma sobre la otra. 
Tienen diferentes casos de uso:

- `require()`:
  - Es una función integrada en Lua. Te permite aprovechar el sistema de módulos de Lua.
  - Busca módulos en las carpetas `lua/` de tu `'runtimepath'`.
  - Mantiene un registro de los módulos que han sido cargados y evita que un script sea analizado 
    y ejecutado por segunda vez. Si cambias el archivo que contiene el código de un módulo e 
    intentas `require()` por segunda vez mientras Neovim se está ejecutando, el módulo no se actualizará.
- `:luafile`, `:source` y `:runtime`:
  - Son comandos Ex. Los módulos no están soportados.
  - Ejecutan el contenido de un script independientemente de que se haya ejecutado antes.
  - `:luafile` y `:source` toman una ruta absoluta o relativa al directorio de trabajo de la ventana actual.
  - `:runtime` utiliza la opción `'runtimepath'` para encontrar los archivos.

Los archivos ejecutados a través de `:source`, `:runtime` o automáticamente desde los directorios de 
ejecución también aparecerán en `:scriptnames` y `--startuptime`.

### luaeval()

Esta función ya incorporada de Vimscript evalúa un string de Lua y devuelve su valor. 
Los tipos de datos de Lua se convierten automáticamente en tipos de Vimscript (y viceversa).


```vim
" Puedes almacenar el valor de una variable
let variable = luaeval('1 + 1')
echo variable
" 2
let concat = luaeval('"Lua".." is ".."awesome"')
echo concat
" 'Lua is awesome'

" Listas que se parecen a tablas son convertias en listas Vim
let list = luaeval('{1, 2, 3, 4}')
echo list[0]
" 1
echo list[1]
" 2
" Nota que a diferencia de las tablas en Lua, las listas en Vim son @-indexadas

" Diccionarios como tablas son convertidos en dictionarios vim
let dict = luaeval('{foo = "bar", baz = "qux"}')
echo dict.foo
" 'bar'

" Lo mismo para boleanos y nil
echo luaeval('true')
" v:true
echo luaeval('nil')
" v:null

" Puedes crear Vimscript-alias para las funciones Lua
let LuaMathPow = luaeval('math.pow')
echo LuaMathPow(2, 2)
" 4
let LuaModuleFunction = luaeval('require("mymodule").myfunction')
call LuaModuleFunction()

" Tambien es posibla pasar una funcion Lua como valor de una función Vim
lua X = function(k, v) return string.format("%s:%s", k, v) end
echo map([1, 2, 3], luaeval("X"))
```

`luaeval()` takes an optional second argument that allows you to pass data to the expression. You can then access that data from Lua using the magic global `_A`:

```vim
echo luaeval('_A[1] + _A[2]', [1, 1])
" 2

echo luaeval('string.format("Lua is %s", _A)', 'awesome')
" 'Lua is awesome'
```

También ve:
- `:help luaeval()`

### v:lua

Esta variable global de Vim te permita llamar funciones Lua en el espacio de nombres global 
 ([`_G`](https://www.lua.org/manual/5.1/manual.html#pdf-_G)) directamente desde Vimscript. De nuevo, los tipos
 de datos de Vim se convierten en tipos de Lua y viceversa.


```vim
call v:lua.print('Hello from Lua!')
" 'Hello from Lua!'

let scream = v:lua.string.rep('A', 10)
echo scream
" 'AAAAAAAAAA'

" How about a nice statusline?
lua << EOF
function _G.statusline()
    local filepath = '%f'
    local align_section = '%='
    local percentage_through_file = '%p%%'
    return string.format(
        '%s%s%s',
        filepath,
        align_section,
        percentage_through_file
    )
end
EOF

set statusline=%!v:lua.statusline()

" Also works in expression mappings
lua << EOF
function _G.check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end
EOF

inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ v:lua.check_back_space() ? "\<Tab>" :
    \ completion#trigger_completion()
```

Tambien ve:
- `:help v:lua`
- `:help v:lua-call`

#### Precaución:

Esta variable solo puede ser usada para llamar funciones. El siguiente código siempre arrojará
error:

```vim
" Aliasing functions doesn't work
let LuaPrint = v:lua.print

" Accessing dictionaries doesn't work
echo v:lua.some_global_dict['key']

" Using a function as a value doesn't work
echo map([1, 2, 3], v:lua.global_callback)
```

### Tips

Puedes tener un resaltado de sintaxis de Lua dentro de los archivos .vim poniendo 
`let g:vimsyn_embed = 'l'` en su archivo de configuración. Vea `:help g:vimsyn_embed` para más 
información sobre esta opción.

## El espacio de nombres de vim

Neovim expone una variable global `vim` que sirve como punto de entrada para interactuar con sus 
APIs desde Lua. Ofrece a los usuarios una "biblioteca estándar" ampliada de funciones, así como 
varios submódulos.

Algunas funciones y módulos notables son:
- `vim.inspect`: imprime esteticamente objetos Lua (útil para inspeccionar tablas).
- `vim.regex`: utiliza regexes de Vim desde Lua.
- `vim.api`: módulo que expone funciones de la API (la misma API utilizada por los plugins remotos).
- `vim.loop`: módulo que expone la funcionalidad del event-loop de Neovim (usando LibUV).
- `vim.lsp`: módulo que controla el cliente LSP incorporado.
- `vim.treesitter`: módulo que expone la funcionalidad de la biblioteca tree-sitter.

Esta lista no es para nada extensa. Si desea saber más sobre lo que está disponible por 
la variable `vim`, `:help lua-stdlib` y `:help lua-vim` son el camino a seguir. Alternativamente, 
puede hacer `:lua print(vim.inspect(vim))` para obtener una lista de cada módulo.

#### Tips

Escribir `print(vim.inspect(x))` cada vez que quieras inspeccionar el contenido de un objeto puede 
resultar muy molesto. Puede ser que valga la pena tener una función envolvente global en algún
lugar de su configuración:

```lua
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
    return ...
end
```


Así, podrá inspeccionar el contenido de un objeto rápidamente en tu código o desde la 
línea de comandos:

```lua
dump({1, 2, 3})
```

```vim
:lua dump(vim.loop)
```


Además, puedes encontrar que las funciones integradas de Lua son a veces deficientes comparadas 
con las que encontrarías en otros lenguajes (por ejemplo `os.clock()` sólo retorna un valor en 
segundos, no en milisegundos). Asegúrate de mirar en Neovim stdlib (y `vim.fn`, más adelante), 
probablemente tenga lo que estás buscando.

## Usando Vimscript desde Lua

### vim.api.nvim_eval()

Esta función evalúa una expresión string de Vimscript y devuelve su valor. Los tipos de datos 
de Vimscript se convierten automáticamente en tipos de Lua (y viceversa).

Es el equivalente en Lua de la función `luaeval()` en Vimscript

```lua
-- Data types are converted correctly
print(vim.api.nvim_eval('1 + 1')) -- 2
print(vim.inspect(vim.api.nvim_eval('[1, 2, 3]'))) -- { 1, 2, 3 }
print(vim.inspect(vim.api.nvim_eval('{"foo": "bar", "baz": "qux"}'))) -- { baz = "qux", foo = "bar" }
print(vim.api.nvim_eval('v:true')) -- true
print(vim.api.nvim_eval('v:null')) -- nil
```


**TODO**: Es posible para `vim.api.nvim_eval()` retornar una `funcref`?

#### Precaución:


A diferencia de `luaeval()`, `vim.api.nvim_eval()` no proporciona una variable implícita `_A` 
para pasar datos a la expresión.


### vim.api.nvim_exec()


Esta función evalúa un trozo de código Vimscript. Toma una cadena que contiene el código fuente a 
ejecutar y un booleano para determinar si la salida del código debe ser retornada por la función 
(puede almacenar la salida en una variable, por ejemplo).


```lua
local result = vim.api.nvim_exec(
[[
let mytext = 'hello world'

function! MyFunction(text)
    echo a:text
endfunction

call MyFunction(mytext)
]],
true)

print(result) -- 'hello world'
```

**TODO**: La documentación dice que el alcance del script (`s:`) está soportado, 
pero ejecutar este snippet con el alcance de un script arrojá un error. ¿Por qué?

### vim.api.nvim_command()

Esta funcion ejecuta un comando ex. Toma el string que contiene el comando que se debe ejecutar.

```lua
vim.api.nvim_command('new')
vim.api.nvim_command('wincmd H')
vim.api.nvim_command('set nonumber')
vim.api.nvim_command('%s/foo/bar/g')
```

### vim.cmd()

Alias for `vim.api.nvim_exec()`. Only the command argument is needed, `output` is always set to `false`.

Alias para `vim.api.nvim_exec()`. Solo el argumento comando es necesitado, `output` estará siempre 
predeterminado en `false`.

```lua
vim.cmd('buffers')
vim.cmd([[
let g:multiline =<< EOF
foo
bar
baz
EOF
]])
```

#### Tips

Cuando quieras pasar cadenas de texto (String) en estas funciones, puedes escapar usando las
barras invertidad:

```lua
vim.cmd('%s/\\Vfoo/bar/g')
```

Literale strings son más fáciles de usar ya que no requieren escapar caracteres:

```lua
vim.cmd([[%s/\Vfoo/bar/g]])
```

### vim.api.nvim_replace_termcodes()


Esta función de la API le permite escapar de los códigos de la terminal y de los códigos de las 
teclas de Vim.

Es posible que te hayas encontrado con mapeos como este:

```vim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
```

Intentar hacer lo mismo en Lua puede resultar en todoun reto. Puedes estar tentado de hacerlo así:

```lua
function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and [[\<C-n>]] or [[\<Tab>]]
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
```

sólo para descubrir que el mapeo inserta `\<Tab>` y `\<C-n>`.

La posibilidad de escapar de los códigos de las teclas es en realidad una característica de Vimscript. 
además de las secuencias de escape habituales como `\r`, `\42` o `\x10` que son comunes a muchos 
lenguajes de programación, las `expr-quotes` de Vimscript (strings rodeadas de comillas dobles) 
te permiten escapar de la representación legible para el ser humano de los códigos de tecla 
de Vim.

Lua no tiene esa función incorporada. Afortunadamente, Neovim tiene una función API para escapar 
los códigos de los terminales y los códigos de las teclas: `nvim_replace_termcodes()`.

```lua
print(vim.api.nvim_replace_termcodes('<Tab>', true, true, true))
```

Esto es un poco verboso. Crear un envoltorio reutilizable puede ayudar:

```lua
-- La función se llama `t` para `termcodes`.
-- No es necesario llamarla así, pero me parece que es conveniente para la
función local t(str)
    -- Ajusta los argumentos booleanos según sea necesario
    return vim.api.nvim_replace_termcodes(str, true, true, true)
fin

print(t'<Tab>')
```


Volviendo a nuestro ejemplo anterior, ahora debería funcionar como se esperaba:

```lua
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<Tab>'
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
```

Mira también:

- `:help keycodes`
- `:help expr-quote`
- `:help nvim_replace_termcodes()`

## Manejando las opciones de vim

### Usando las funciones de la API

Neovim proporciona un conjunto de funciones API para establecer una opción u obtener su valor 
actual:

- Opciones globales:
    - `vim.api.nvim_set_option()`
    - `vim.api.nvim_get_option()`
- Opciones de buffer-local:
    - `vim.api.nvim_buf_set_option()`
    - `vim.api.nvim_buf_get_option()`
- Opciones de ventana-local:
    - `vim.api.nvim_win_set_option()`
    - `vim.api.nvim_win_get_option()`

Toman un string que contiene el nombre de la opción a establecer/obtener, así como el valor 
que desea establecer.

Las opciones booleanas (como `(no)number`) deben establecerse como `true` o `false`:

```lua
vim.api.nvim_set_option('smarttab', false)
print(vim.api.nvim_get_option('smarttab')) -- false
```
Como es lógico, las opciones de cadena de texto tienen que establecerse en un string:

```lua
vim.api.nvim_set_option('selection', 'exclusive')
print(vim.api.nvim_get_option('selection')) -- 'exclusive'
```

Las opciones numéricas aceptan un número:

```lua
vim.api.nvim_set_option('updatetime', 3000)
print(vim.api.nvim_get_option('updatetime')) -- 3000
```
Las opciones "Buffer-local" y "window-local" también 
necesitan un número de buffer o de ventana (el uso de "0" establecerá/obtendrá la opción 
para el buffer/ventana actual):

```lua
vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_buf_set_option(10, 'shiftwidth', 4)
print(vim.api.nvim_win_get_option(0, 'number')) -- true
print(vim.api.nvim_buf_get_option(10, 'shiftwidth')) -- 4
```

### Using meta-accessors

Las variables internas se pueden manipular de forma más intuitiva utilizando estos meta-accesos:


- `vim.g.{name}`: variables globales
- `vim.b.{name}`: variables de buffer
- `vim.w.{name}`: variables de ventana
- `vim.t.{name}`: variables de tab-page
- `vim.v.{name}`: Vim variables predefinidas de Vim
- `vim.env.{name}`: variables de ambiente (entorno)

```lua
vim.g.some_global_variable = {
    key1 = 'value',
    key2 = 300
}

print(vim.inspect(vim.g.some_global_variable)) -- { key1 = "value", key2 = 300 }
```
Algunos nombres de variables pueden contener caracteres que no pueden ser utilizados como 
identificadores en Lua. Aún así puedes manipular estas variables utilizando esta 
sintaxis: `vim.g['mi#variable']`.

Para eliminar una de estas variables, simplemente asigna `nil` a la misma:

```lua
vim.g.some_global_variable = nil
```

See also:
- `:help lua-vim-variables`

#### Precaución

A diferencia de las opciones meta-accesos, no se puede especificar un número para las variables
de ámbito buffer/ventana/página de pestañas.

Además, no puedes añadir/actualizar/borrar claves de un diccionario almacenado en una de estas 
variables. Por ejemplo, este fragmento de código Vimscript no funciona como se esperaba:

```vim
let g:variable = {}
lua vim.g.variable.key = 'a'
echo g:variable
" {}
```

Puedes utilizar una variable temporal como solución:

```vim
let g:variable = {}
lua << EOF
local tmp = vim.g.variable
tmp.key = 'a'
vim.g.variable = tmp
EOF
echo g:variable
" {'key': 'a'}
```

Este es un problema conocido:

- [Issue #12544](https://github.com/neovim/neovim/issues/12544)

## Llamando a funciones de Vimscript

### vim.fn.{function}()

Se puede utilizar `vim.fn` para llamar a una función de Vimscript. Los tipos de datos se 
convierten de un lado a otro de Lua a Vimscript.

```lua
print(vim.fn.printf('Hello from %s', 'Lua'))

local reversed_list = vim.fn.reverse({ 'a', 'b', 'c' })
print(vim.inspect(reversed_list)) -- { "c", "b", "a" }

local function print_stdout(chan_id, data, name)
    print(data[1])
end

vim.fn.jobstart('ls', { on_stdout = print_stdout })
```

Los hash (`#`) no son caracteres válidos para los identificadores en Lua, por lo que las 
funciones de autocarga tienen que ser llamadas con esta sintaxis:

```lua
vim.fn['my#autoload#function']()
```

La funcionalidad de `vim.fn` es idéntica a la de `vim.call`, pero permite una sintaxis 
más parecida a la de Lua.

Se diferencia de `vim.api.nvim_call_function` en que la conversión de objetos Vim/Lua es 
automática: `vim.api.nvim_call_function` retorna una tabla para números de punto flotante 
y no acepta closures de Lua mientras que `vim.fn` maneja estos tipos de forma transparente.

También ve:
- `:help vim.fn`

#### Tips

Neovim tiene una extensa biblioteca de potentes funciones incorporadas que son muy útiles 
para los plugins. Consulta `:help vim-function` para una lista alfabética y `:help function-list` 
para una lista de funciones agrupadas por temas.

Las funciones de la API de Neovim pueden utilizarse directamente a través de `vim.api.{..}`. 
Ver `:help api` para más información.


#### Precauciones

Algunas funciones de Vim que deberían devolver un booleano devuelven `1` o `0` en su lugar. 
Esto no es un problema en Vimscript, ya que `1` es verdadero y `0` falso, lo que permite 
construcciones como éstas:

```vim
if has('nvim')
    " do something...
endif
```
En Lua, sin embargo, sólo `false` y `nil` se consideran falsos (falsy), los números siempre se 
evalúan como `true` sin importar su valor. Tienes que comprobar si explícitamente se trata 
de `1` o `0`:

```lua
if vim.fn.has('nvim') == 1 then
    -- do something...
end
```

## Definiendo los mapeos

Neovim proporciona una lista de funciones de la API para establecer, obtener y eliminar mapeos:

- Mapeo global:
    - `vim.api.nvim_set_keymap()`
    - `vim.api.nvim_get_keymap()`
    - `vim.api.nvim_del_keymap()`
- Mapeo de buffer-local:
    - `vim.api.nvim_buf_set_keymap()`
    - `vim.api.nvim_buf_get_keymap()`
    - `vim.api.nvim_buf_del_keymap()`

Empecemos con `vim.api.nvim_set_keymap()` y `vim.api.nvim_buf_set_keymap()`.

El primer argumento que se pasa a la función es un string que contiene el nombre del modo para 
el que el mapeo tendrá efecto:

| String value           | Help page     | Affected modes                           | Vimscript equivalent |
| ---------------------- | ------------- | ---------------------------------------- | -------------------- |
| `''` (an empty string) | `mapmode-nvo` | Normal, Visual, Select, Operator-pending | `:map`               |
| `'n'`                  | `mapmode-n`   | Normal                                   | `:nmap`              |
| `'v'`                  | `mapmode-v`   | Visual and Select                        | `:vmap`              |
| `'s'`                  | `mapmode-s`   | Select                                   | `:smap`              |
| `'x'`                  | `mapmode-x`   | Visual                                   | `:xmap`              |
| `'o'`                  | `mapmode-o`   | Operator-pending                         | `:omap`              |
| `'!'`                  | `mapmode-ic`  | Insert and Command-line                  | `:map!`              |
| `'i'`                  | `mapmode-i`   | Insert                                   | `:imap`              |
| `'l'`                  | `mapmode-l`   | Insert, Command-line, Lang-Arg           | `:lmap`              |
| `'c'`                  | `mapmode-c`   | Command-line                             | `:cmap`              |
| `'t'`                  | `mapmode-t`   | Terminal                                 | `:tmap`              |


El segundo argumento es una cadena (string) que contiene el lado izquierdo del mapeo (la clave o 
conjunto de claves que activan el comando definido en el mapeo). Una cadena vacía equivale 
a `<Nop>`, que desactiva una clave.

El tercer argumento es un string que contiene el lado derecho del mapeo (el comando a ejecutar).

El argumento final es una tabla que contiene las opciones booleanas para el mapeo como se define 
en `:help :map-arguments` (incluyendo `noremap` y excluyendo `buffer`).

Los mapeos locales del buffer también toman un número de buffer como su primer argumento 
(`0` establece el mapeo para el buffer actual).

```lua
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- :nnoremap <silent> <Leader><Space> :set hlsearch<CR>
vim.api.nvim_set_keymap('n', '<Leader>tegf',  [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
-- :nnoremap <silent> <Leader>tegf <Cmd>lua require('telescope.builtin').git_files()<CR>

vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'
```

`vim.api.nvim_get_keymap()` toma un string que contiene el nombre corto del modo para el que 
se quiere la lista de mapeos (ver tabla anterior). El valor retornado es una tabla que contiene 
todas las asignaciones globales para el modo.

```lua
print(vim.inspect(vim.api.nvim_get_keymap('n')))
-- :verbose nmap
```

`vim.api.nvim_buf_get_keymap()` takes an additional buffer number as its first argument (`0` will get mapppings for the current bufffer)

```lua
print(vim.inspect(vim.api.nvim_buf_get_keymap(0, 'i')))
-- :verbose imap <buffer>
```

`vim.api.nvim_del_keymap()` takes a mode and the left-hand side of a mapping.

```lua
vim.api.nvim_del_keymap('n', '<Leader><Space>')
-- :nunmap <Leader><Space>
```

Again, `vim.api.nvim_buf_del_keymap()`, takes a buffer number as its first argument, with `0` representing the current buffer.

```lua
vim.api.nvim_buf_del_keymap(0, 'i', '<Tab>')
-- :iunmap <buffer> <Tab>
```


## Definiendo comando de usuario

Actualmente no existe una interfaz para crear comandos de usuario en Lua. Sin embargo, 
se está planeando hacer lo siguiente:

- [Pull request #11613](https://github.com/neovim/neovim/pull/11613)

Por los momentos, probablemente sea mejor crear comandos en Vimscript.


## Definiendo autocomandos

Augroups y autocommands no tienen interfaces aun pero se está trabajando en ello:

- [Pull request #12378](https://github.com/neovim/neovim/pull/12378)

Mientras tanto, puedes crear autocomandos en Vimscript o 
utilizar [esta envoltura de norcalli/nvim_utils](https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567)

## Definiendo la sintaxis/resultados

La API de sintaxis es todavía un trabajo en progreso. Aquí hay un par de indicaciones:

- [Issue #9876](https://github.com/neovim/neovim/issues/9876)
- [tjdevries/colorbuddy.vim, a library for creating colorschemes in Lua](https://github.com/tjdevries/colorbuddy.vim)
- `:help lua-treesitter`

## Tips generales y recomendaciones


### Recargando los modulos de caches

En Lua, la función `require()` almacena en caché los módulos. Esto es bueno para el rendimiento,
pero puede hacer que el trabajo con los plugins sea un poco engorroso porque los módulos no se 
actualizan en las siguientes llamadas a `require()`.

Si quieres refrescar la caché de un módulo en particular, tienes que modificar la tabla 
global `package.loaded`:

```lua
package.loaded['modname'] = nil
require('modname') -- loads an updated version of module 'modname'
```

El plugin [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) tiene 
una [función personalizada](https://github.com/nvim-lua/plenary.nvim/blob/master/lua/plenary/reload.lua) que hace esto por ti.

### Notas sobre la conversión de tipos Vimscript <-> Lua

#### Convertir una variable crea una copia:
No puedes interactuar directamente con la referencia a un objeto Vim desde Lua o un objeto Lua 
desde Vimscript.  
Por ejemplo, la función `map()` de Vimscript modifica una variable en su lugar:

```vim
let s:list = [1, 2, 3]
let s:newlist = map(s:list, {_, v -> v * 2})

echo s:list
" [2, 4, 6]
echo s:newlist
" [2, 4, 6]
```

Usando esta función de Lua se crea una copia en su lugar:

```lua
local tbl = {1, 2, 3}
local newtbl = vim.fn.map(tbl, function(_, v) return v * 2 end)

print(vim.inspect(tbl)) -- { 1, 2, 3 }
print(vim.inspect(newtbl)) -- { 2, 4, 6 }
```

#### La conversión no siempre es posible
Esto afecta principalmente a funciones y tablas:

Las tablas de Lua que son una mezcla entre una Lista y un Diccionario no pueden ser convertidas:

```lua
print(vim.fn.count({1, 1, number = 1}, 1))
-- E5100: Cannot convert given lua table: table should either have a sequence of positive integer keys or contain only string keys
```

Mientras que puedes llamar a funciones de Vim en Lua con `vim.fn`, no puedes mantener 
referencias a ellas. Esto puede causar comportamientos extraños:

```lua
local FugitiveHead = vim.fn.funcref('FugitiveHead')
print(FugitiveHead) -- vim.NIL

vim.cmd("let g:test_dict = {'test_lambda': {-> 1}}")
print(vim.g.test_dict.test_lambda) -- nil
print(vim.inspect(vim.g.test_dict)) -- {}
```

Pasar funciones de Lua a funciones de Vim está bien, almacenarlas en variables de Vim no lo es:

```lua
-- Esto funciona:
vim.fn.jobstart({'ls'}, {
    on_stdout = function(chan_id, data, name)
        print(vim.inspect(data))
    end
})


-- Esto no;
vim.g.test_dict = {test_lambda = function() return 1 end} -- Error: Cannot convert given lua type
```


Sin embargo, ten en cuenta que hacer lo mismo desde Vimscript con `luaeval()` **funciona**:

```vim
let g:test_dict = {'test_lambda': luaeval('function() return 1 end')}
echo g:test_dict
" {'test_lambda': function('<lambda>4714')}
```

#### Booleanos de Vim
Un patrón común en los scripts de Vim es utilizar `1` o `0` en lugar de booleanos propiamente dichos. 
De hecho, Vim no tuvo un tipo booleano separado hasta la versión 7.4.1154.

Los booleanos de Lua se convierten en booleanos reales en Vimscript, no en números:


```vim
lua vim.g.lua_true = true
echo g:lua_true
" v:true
lua vim.g.lua_false = false
echo g:lua_false
" v:false
```

### Estableciendo los linters/language servers

Si utilizas linters y/o servidores de lenguaje para obtener diagnósticos y autocompletar los 
proyectos Lua, es posible que tengas que configurar ajustes específicos de Neovim para ellos. 
Aquí tienes algunas configuraciones recomendadas para las herramientas más populares:


#### Luacheck

Puedes hacer que [luacheck](https://github.com/mpeterv/luacheck/) reconozca el global `vim` 
poniendo esta configuración en `~/.luacheckrc` (o `$XDG_CONFIG_HOME/luacheck/.luacheckrc`):

```lua
globals = {
    "vim",
}
```

El servidor de idiomas [Alloyed/lua-lsp](https://github.com/Alloyed/lua-lsp/) utiliza `luacheck` 
para proporcionar linting y leer el mismo archivo.

Para más información de como configurar `luacheck`, por favor ir a la
[documentación](https://luacheck.readthedocs.io/en/stable/config.html)


#### sumneko/lua-language-server

El repositorio de [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) contiene 
[instrucciones para configurar sumneko/lua-language-server](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#sumneko_lua) 
(el ejemplo utiliza el cliente LSP incorporado pero la configuración debería ser idéntica 
para otras implementaciones de clientes LSP).

Para más información de como configurar [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server/) mira ["Setting without VSCode"](https://github.com/sumneko/lua-language-server/wiki/Setting-without-VSCode)


#### coc.nvim

La fuente completa de [rafcamlet/coc-nvim-lua](https://github.com/rafcamlet/coc-nvim-lua/) 
para [coc.nvim](https://github.com/neoclide/coc.nvim/) provee elementos para la completación 
de Neovim stdlib .

### Depurar el código de Lua

Puedes depurar el código Lua que se ejecuta en una instancia separada de Neovim 
con [jbyuki/one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind)

El plugin utiliza el [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/). La conexión a un adaptador de depuración requiere un cliente DAP como [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap/) o [puremourning/vimspector](https://github.com/puremourning/vimspector/).

### Probando (testing) el código de lua

- [plenary.nvim: test harness](https://github.com/nvim-lua/plenary.nvim/#plenarytest_harness)
- [notomo/vusted](https://github.com/notomo/vusted)


### Usando paquetes Luarocks

[wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) soporta paquetes Luarocks. Las intrucciones de como establecer esto están en el [README](https://github.com/wbthomason/packer.nvim/#luarocks-support)


## Micelaneos

### vim.loop

`vim.loop` es el módulo que expone la API de LibUV. Algunos recursos:

- [Documentación oficial de LibUV](https://docs.libuv.org/en/v1.x/)
- Documentación de Luv](https://github.com/luvit/luv/blob/master/docs.md)
- Teukka.tech - Uso de LibUV en Neovim](https://teukka.tech/posts/2020-01-07-vimloop/)

También ve:
- `:help vim.loop`

### vim.lsp

`vim.lsp` es el módulo que controla el cliente LSP incorporado. El repositorio [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) contiene configuraciones por defecto para servidores de idiomas populares.


El comportamiento del cliente puede configurarse mediante "lsp-handlers". Para más información:
- `:help lsp-handler`
- [neovim/neovim#12655](https://github.com/neovim/neovim/pull/12655)
- Cómo migrar desde diagnostic-nvim](https://github.com/nvim-lua/diagnostic-nvim/issues/73#issue-737897078)

También puedes echar un vistazo a los plugins construidos alrededor del cliente LSP:
- [nvim-lua/completion-nvim](https://github.com/nvim-lua/completion-nvim)
- [RishabhRD/nvim-lsputils](https://github.com/RishabhRD/nvim-lsputils)

También ve:
- `:help lsp`

### vim.treesitter

`vim.treesitter` es el módulo que controla la integración de la biblioteca [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) en Neovim. 
Si quieres saber más sobre Tree-sitter, puede interesarte esta [presentación (38:37)](https://www.youtube.com/watch?v=Jes3bD6P0To).

La organización [nvim-treesitter](https://github.com/nvim-treesitter/) 
alberga varios plugins que toman ventaja de la biblioteca.


También ve:
- `:help lua-treesitter`

### Transpiladores

Una de las ventajas de utilizar Lua es que no hay que escribir código. Hay una multitud de 
transpiladores disponibles para el lenguaje.

- [Moonscript](https://moonscript.org/)

Probablemente uno de los transpiladores más conocidos para Lua. Añade un montón de características convenientes como clases, comprensión de listas o 
funciones literales. El plugin [svermeulen/nvim-moonmaker](https://github.com/svermeulen/nvim-moonmaker) permite escribir plugins y configuraciones de Neovim directamente en Moonscript.

- [Fennel](https://fennel-lang.org/)

Un lisp que compila en Lua. Puedes escribir configuraciones y plugins para Neovim en Fennel 
con el plugin [Olical/aniseed](https://github.com/Olical/aniseed). Además, 
el plugin [Olical/conjure](https://github.com/Olical/conjure) proporciona un entorno de 
desarrollo interactivo que soporta Fennel (entre otros lenguajes).

Otros proyectos interesantes:

- [TypeScriptToLua/TypeScriptToLua](https://github.com/TypeScriptToLua/TypeScriptToLua)
- [teal-language/tl](https://github.com/teal-language/tl)
- [Haxe](https://haxe.org/)
- [SwadicalRag/wasm2lua](https://github.com/SwadicalRag/wasm2lua)
- [hengestone/lua-languages](https://github.com/hengestone/lua-languages)
