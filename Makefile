docs:
	stack exec -- haddock --html src/Data/Cell.hs src/Data/Dependency.hs src/Data/Ejemplo.hs src/Data/ExternalModule.hs src/Data/Messages.hs src/Data/Parsing.hs src/Data/ServerState.hs src/Lib/Application.hs src/Lib/Cell.hs src/Lib/CodeGen.hs src/Lib/Dependency.hs src/Lib/Eval.hs src/Lib/ExternalModule.hs src/Lib/Indexing.hs src/Lib/Parsing.hs src/Lib/ServerState.hs app/Main.hs --hyperlinked-source --odir=doc --latex

build:
	stack build

clean:
	rm -rf .stack-work
	rm -rf dist
	stack clean
