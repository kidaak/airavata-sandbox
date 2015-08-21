/* HF Keywords
   Last Update: 12/31/2000 
   http://www.gaussian.com/00000445.htm
*/


 
%%



%class HF
%public
%unicode
/*
%cup
%cupdebug
*/
%ignorecase

%state FLOATVAL
%state IGNOREALL

%standalone
%8bit
%{
  public static boolean DEBUG = false;
%}

/* ______
   Macros */
LineTerminator = \r|\n|\r\n 
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f] 

/* ________
   Comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}
TraditionalComment = "/*" [^*] ~"*/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*         /* adjust syntax font-lock */
Identifier = [:jletter:] [:jletterdigit:]*

/* ________________________________________________________________
   A literal integer is is a number beginning with a number between 
   one and nine followed by zero or more numbers between 
   zero and nine or just a zero. 

   A identifier integer is a word beginning a letter between A and Z, 
   a and z, or an underscore followed by zero or more letters between 
   A and Z, a and z, zero and nine, or an underscore. */ 
dec_int_lit    = 0 | [1-9][0-9]* 
dec_int_id     = [A-Za-z_][A-Za-z_0-9]* 
DIGIT          = [0-9]
FLOAT          = [+|-]?{DIGIT}+"."{DIGIT}*(["D"|"d"|"E"|"e"]([+|-]?){DIGIT}+)?
INT            = [+|-]?{DIGIT}+
BOOL           = [T|F]
WORD           = [A-Za-z]+
WORDLIST       = ["("]? [1A-Za-z]+ (","[A-Za-z]+)* [")"]?
GRAB           = [^(" "|\r|\n|\r\n| \t\f)]+
TOEOL          = ~(\r|\n|\r\n)


 
%%



/* __________________
   Examples, Energies */

<YYINITIAL>{
  "E(RHF)" {
            yybegin(FLOATVAL);
  }
  "A.U. after" {}
  "cycles" {}
  "Convg" {
           yybegin(FLOATVAL);
  }
  "-V/T" {
          yybegin(FLOATVAL);
  }
  "S**2" {
          yybegin(FLOATVAL);
  }
  {INT} {}
  .|\n {}
}


<FLOATVAL>{
  {FLOAT} {if (Settings.DEBUG) System.out.println(yytext());
  }
}


<IGNOREALL>{
  .|\n {}
}

.|\n {}
  
