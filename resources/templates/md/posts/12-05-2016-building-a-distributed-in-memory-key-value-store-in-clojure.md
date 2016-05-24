{:title  "Building a distributed in-memory key value store in Clojure."
 :layout :post
 :date   "12-05-2016"
 :tags   ["clojure" "memdi"]}

In this series we are going to build a distributed in-memory key value store, from scratch, using Clojure. Why? For learning and fun!

The distributed in-memory store will be called [`memdi`](https://github.com/markwoodhall/memdi) and will have the following semantics.

* There will be a single master node and N follower nodes
* Any node will accept the write request and write the key-value to the master
* A write is considered successful if the data is stored in-memory on the master
* Follower nodes can heal by requesting keys from the master
* New follower nodes are manually added to a cluster (no discovery) and can request all keys from the master
* All follower nodes perform a heartbeat with the master and can invoke a leader election, promoting themselves to a candidate

I'm going to break the series into the following posts:

### 1. Building out a skeleton

We will get the basic of the application together, starting from a `lein new app memdi`.


### 2. Handling our first, in process, replicated write

We will create enough of the application to have the core concepts and will be able to handle a write to master node with in process replication.

### 3. Handling in process heartbeats

Still working just in process we add the code required to handle heartbeats between master and follower nodes.

### 4. Handling in process elections

Here we add code required to manage an election process initiated by a follower node losing contact with the master.

### 5. Handling our first "real" replicated write

We will be able to send a write request to the cluster and have the key-value replicate across "real" nodes as apposed to our in process nodes.

### 6. Handling heart beats across nodes

We now add the functionality for follower nodes to monitor the masters heartbeat across process/machine boundaries.

### 7. Handling elections

Making use of the logic created previously we enable a follower node to initiate a leader elections across process/machine boundaries.

For all of the development above we will be using the repl as the client to our cluster. At some point we will want to develop a real client implementation. It would also be cool if we can design the store in such a way that it can optionally use asynchronous file IO to support durable writes and that we can configure it to treat a successful write as either in-memory or to-disk.
