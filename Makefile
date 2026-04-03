CXX = g++
CXXFLAGS = -std=c++17
LEX = flex

TARGET = ./tree

LEX_SRC = ./tree.l
LEX_OUT = ./tree.yy.cpp

all: $(TARGET) 

$(LEX_OUT): $(LEX_SRC)
	$(LEX) -o $(LEX_OUT) $(LEX_SRC)

$(TARGET): $(LEX_OUT)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(LEX_OUT)

clean:
	rm $(TARGET) $(LEX_OUT) *.txt