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
    global equivClass = 0
    global classDict = Dict()
    i=0
    for i=0:(2^10)-1
        global Istring= string(i, base = 2, pad = 10)#bitstring of length 10 for i

        #set currGraph based on said string
        currGraph=falses(1,10)
        for j=1:10
            if Istring[j]=='1'
                currGraph[j]= 1
            end
        end

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
    permsOnGraph=Array{Union{Nothing, BitArray}}(nothing, 1, 2)
    i=1;
    for currPermutation in collect(permutations([1,2,3,4,5]))
        permsOnGraph[i]=falses(1,10)
        global j=1
        for j=1:10
            if graph[j]==1 #if this edge exists in original graph
                edge= getEdge(j)
                firstVertice= pop!(edge)
                secondVertice= pop!(edge)

                #get edge equiv to original edge under currPermutation
                firstVertice= currPermutation[firstVertice]
                secondVertice= currPermutation[secondVertice]
                edge= push!(edge,firstVertice,secondVertice)
                index= getIndex(edge)

                #set it as existing
                permsOnGraph[i][index]=1
            end
        end
        dictionary[permsOnGraph[i]]=equivClass
        i+=1
    end
end

#helper function that given an index in bitArray gives the edge it represents
function getEdge(index)
    edge= Set{Int8}()
    if index<=4
        edge=push!(edge,1,(index+1))

    elseif (5<=index && index<=7)
        edge=push!(edge,2,(index-2))

    elseif (index==8||index==9)
        edge=push!(edge,3,(index-4))

    elseif index==10
        edge=push!(edge,4,5)
    end
    return edge
end

#helper function that given an edge of a graph gives the index in bitArray for it
function getIndex(edge)
    i=1
    for i=1:10
        if issetequal(edge, getEdge(i))
            return i
        end
    end
end