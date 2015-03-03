

/* define lexicon */

%lex
%%

\s+	{}
"AND"	{return "AND"}
"OR"	{return "OR"}
"LIKE"|"~"	{return "LIKE"}
"EQUALS"|"="	{return "EQUALS"}
(["'])(?:(?=(\\?))\2.)*?\1 {return "WORD"}
"("                   { return "OPEN" }
")"                   { return "CLOSE" }
^[_a-zA-Z:-]*\w {return 'FIELD'}
^[_a-zA-Z]*\w {return 'FIELD'}
<<EOF>>	{return "EOF"}

/lex


/* Operators */

%right AND OR
%start START

/* define grammar */

%%

START : EXP EOF { return $1};

EXP : 
	EXP AND EXP {$$ = function(obj){ return ($1(obj) && $3(obj));};}
	| EXP OR EXP {$$ = function(obj){return ($1(obj) || $3(obj));};}
	| FIELD LIKE WORD { $$ = function(obj){return $1(obj)};}
	| FIELD EQUALS WORD { $$ = function(obj){return $1(obj)};}
	| OPEN EXP CLOSE { $$ = $2; }
    | ARGS
        { $$ = function(obj) { return parser.processArgs(obj, $1)(obj); }; }	
	;