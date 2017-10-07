#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main() {

  int errorRate = 0;

  ifstream clang, lex;
  clang.open ("clangTokens.txt");
  lex.open ("lexTokens.txt");

  if (clang.is_open() && lex.is_open()) {

      string clangLine, lexLine, clangToken, lexToken;

    while (getline(clang,clangLine) && getline(lex, lexLine)) {
      clangToken = clangLine.substr(0, clangLine.find('\t'));
      lexToken = lexLine;

      if (clangToken.compare(lexToken) != 0) {
        errorRate++;
        cout << "Right is ->" << clangToken << "<- flex token is: ->" << lexToken << "<-\n";
      }
    }
  }

  if (errorRate == 0) {
    cout << "Good!\n";
  }

  clang.close();
  lex.close();
  return 0;
}
