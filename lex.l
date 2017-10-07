%{
#include <iostream>
#include <string>
#define YY_DECL extern "C" int yylex()
using namespace std;

void notificate(string text) {
cout << text << " '" << yytext << "'" << endl;
}
%}
%%


[ \t\n]               						;     /* Spaces, tabs, newlines */
\/\/.*                						;			/* One line comments */
\/\*[^*]*\*+([^*/][^*]*\*)*\/ 		;			/* Multi line comments */
"#".*															;	    /* Lines after preprocessors work */


protected|typeid|mutable|for|if|else|do|continue|break|while|switch|case|new|default|auto|sizeof|enum|return|this|virtual|explicit|true|false|delete|signed|friend|namespace|typedef|bool|long|int|double|float|unsigned|inline|class|private|public|operator|template|typename|void|struct|char|wchar_t|union|extern|const|throw|try|static_cast|reinterpret_cast|const_cast|dynamic_cast|volatile|static|catch|short|using notificate(yytext);


__restrict|__restrict__		notificate("restrict"); /* Compiler reserved words */
__asm|__asm__  						notificate("asm");
__inline				  		    notificate("inline");
__decltype 				  		  notificate("decltype");
__attribute__				  		notificate("__attribute");
__extension__				  		notificate("__extension__");
__typeof|__typeof__       notificate("typeof");
__const__          				notificate("const");
__alignof__         			notificate("__alignof");
__is_literal_type         notificate("__is_literal");
__attribute|__alignof|__attribute|__null|__is_scalar|__is_signed|__is_literal|__alignof|__is_void|__is_pointer|__is_arithmetic|__is_final|__is_union|__underlying_type|__is_base_of|__int128|__float128|__is_enum|__is_class|__is_trivial|__is_trivially_copyable|__is_standard_layout|__is_pod|__is_literal|__is_empty|__is_polymorphic|__is_final|__is_abstract|__is_trivially_constructible|__is_trivially_assignable|__has_trivial_destructor|__has_trivial_constructor|__has_trivial_copy|__has_trivial_assign|__has_virtual_destructor					notificate(yytext);

","										notificate("comma");
"."										notificate("period");
"..."									notificate("ellipsis");
"("										notificate("l_paren");
")"										notificate("r_paren");
"{"|"<%"              notificate("l_brace");
"}"|"%>"							notificate("r_brace");
"["|"<:"							notificate("l_square");
"]"|":>"							notificate("r_square");
"#"|"%:"							notificate("hash");
"##"|"%:%:"					  notificate("hashhash");
";"										notificate("semi");
"="										notificate("equal");
"+"										notificate("plus");
"-"										notificate("minus");
"/"										notificate("slash");
"*"										notificate("star");
"%"										notificate("percent");
":"										notificate("colon");
"::"									notificate("coloncolon");
"?"										notificate("question");
">"										notificate("greater");
"<"										notificate("less");
"!"|not								notificate("exclaim");
"~"|compl							notificate("tilde");
"&"|bitand						notificate("amp");
"&&"|and							notificate("ampamp");
"|"|bitor							notificate("pipe");
"||"|or								notificate("pipepipe");
"^"|xor								notificate("caret");
"<<"									notificate("lessless");
">>"									notificate("greatergreater");
"->"									notificate("arrow");
"->*"									notificate("arrowstar");
".*"									notificate("periodstar");
">="									notificate("greaterequal");
"<="									notificate("lessequal");
"=="									notificate("equalequal");
"+="									notificate("plusequal");
"-="									notificate("minusequal");
"*="									notificate("starequal");
"/="									notificate("slashequal");
"%="									notificate("percentequal");
"!="|not_eq						notificate("exclaimequal");
"&="|and_eq						notificate("ampequal");
"|="|or_eq						notificate("pipeequal");
"^="|xor_eq						notificate("caretequal");
"<<="									notificate("lesslessequal");
">>="									notificate("greatergreaterequal");
"++"									notificate("plusplus");
"--"									notificate("minusminus");


\'((([\x20-\x26\x28-\x5B\x5D-\x7E])+)|((\\([\\\'\"\?\/abfnrtv])+|u[A-F0-9]{4}|U[A-F0-9]{8}|[0-7]+|x[A-F0-9]{2})))\'	notificate("char_constant"); /* http://en.cppreference.com/w/cpp/language/character_literal */

(u8|u|U)?\"([\x00-\x21\x23-\x5B\x5D-\x7E]|\\([\\\'\"\?\/abfnrtv]))*\"			notificate("string_literal"); /* http://en.cppreference.com/w/cpp/language/string_literal */
L\"([\x00-\x21\x23-\x5B\x5D-\x7E]|\\([\\\'\"\?\/abfnrtv]))*\"							notificate("wide_string_literal");


[a-zA-Z_][_a-zA-Z0-9]*  notificate("identifier");

(((0b|0B)[01]*|(0x|0X)[0-9a-fA-F]+|[0-9][0-9]*[0-7]*)(u|U|l|L|ll|LL)*) notificate("numeric_constant");	/* Just integers as described http://en.cppreference.com/w/cpp/language/integer_literal*/

([0-9]+\.[0-9]*|\.[0-9]+|[0-9]+)([eEpP][-+]?[0-9]+)?[fFlL]?				notificate("numeric_constant");	/* float */

(0x|0X)([0-9a-fA-F]+\.[0-9a-fA-F]*|\.[0-9a-fA-F]+|[0-9a-fA-F]+)([eEpP]-?[0-9]+)?[fFlL]?			notificate("numeric_constant"); 	/* hex */


<<EOF>>								{notificate("eof"); yyterminate();}
%%

int main(int argc, char* argv[]) {
				FILE *input = fopen(argv[1], "r");
				// Set up input as file
				yyin = input;
    // lex through the input:
    yylex();
}
