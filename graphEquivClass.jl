using Combinatorics #package to get all permutations

#Equivalency is by isomorphism in this case. Equivalence class refers to all
#graphs isomorphic to each other

# function that returns table of equivalence class of graph produced by change
# of every one edge of each graph equivalence class 
function changesTable()

end

# helper function that returns dictionary with keys being graphs
# and values being graph equivalency class 
function equivClassDict()
    equivClass = 0
    classDict = Dict()
    i=0
    for i=0:(2^10)-1
        Istring= string(i, base = 2, pad = 10)#bitstring of length 10 for i
        print(IString)

        #set currGraph based on said string
        currGraph=falses(1,10)
        for j=1:10
            if Istring[j]=='1'
                currGraph[j]= 1
            end
        end
        print(currGraph)

        if(!haskey(classDict,currGraph)) #if haven't dealt with this graph yet
            #add graph and all its' permutations to dictionary
            classDict[currGraph]=equivClass
            addPermutations(currGraph, equivClass, classDict)
            #set equivalence class for next new graph
            equivClass += 1
        end
    end
    println(equivClass) #sanity check- this should be 34
    return(classDict)
end

# helper function that adds all permutations of given graph to given dictionary
function addPermutations(graph, equivClass, dictionary)
    #get all possible permutations
    permutations=collect(permutations([1,2,3,4,5]))

    for currPermutation in permutations
    #TODO: check how each permutation affects given graph
        
    end
end