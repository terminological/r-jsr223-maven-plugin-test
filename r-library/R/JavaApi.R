# Generated by maven-r-jsr223-plugin: do not edit by hand
# returns a reference to a java class in a jsr223 engine
JavaApi = R6::R6Class("JavaApi", public=list( 
	#### fields ----
	.engine = NULL,
	.objId = 0,
	TestRApi = NULL,
	AnotherTestRApi = NULL,
  
  	changeLogLevel = function(logLevel) {
  	self$.engine$logLevel = logLevel;
  	self$.engine %@% '
  	  import org.apache.log4j.Logger;
  	  import org.apache.log4j.Level;
  		Logger.getRootLogger().setLevel(Level.toLevel(logLevel));
  	'
	},
	
 	#### constructor ----
 	initialize = function(logLevel = "warn") {
	
	# initialise java engine
	
	class.path <- c(
		system.file("java", "groovy-all-2.4.17.jar", package="testRapi"),
		system.file("java", "slf4j-log4j12-1.7.22.jar", package="testRapi"),
		system.file("java", "log4j-1.2.17.jar", package="testRapi"),
		system.file("java", "slf4j-api-1.7.22.jar", package="testRapi"),
		system.file("java", "r-jsr223-maven-plugin-test-1.04-jar-with-dependencies.jar", package="testRapi")
	)	
	self$.engine = jsr223::ScriptEngine$new("groovy", class.path)
	self$.engine$setDataFrameRowMajor(TRUE)
	self$.engine$logLevel = logLevel;
	# set up engine
	self$.engine %@% '
		import org.slf4j.Logger;
		import org.slf4j.LoggerFactory;
		import org.apache.log4j.BasicConfigurator;
		import org.apache.log4j.Logger;
		import org.apache.log4j.Level;
		
		BasicConfigurator.configure();
		Logger.getRootLogger().setLevel(Level.toLevel(logLevel));

		log = LoggerFactory.getLogger("testRapi");
		log.info("logging initialised");

		objs = [];
		nextObjId = 0;
	'
	
	
	# initialise constructor and static class definitions
	self$TestRApi = list(
		new = function() {
			# constructor
			# copy parameters
			objId = self$.engine %~% '
				synchronized(objs) {
					objs[nextObjId] = new uk.co.terminological.mavenrjsr233plugintest.TestRApi();
					nextObjId = nextObjId+1 
				}
				return nextObjId-1;
			'
			# delete parameters
			return(TestRApi$new(self$.engine, objId))
		}	
	)
	self$AnotherTestRApi = list(
		new = function(message1, message2) {
			# constructor
			# copy parameters
		self$.engine$tmp_message1 = message1; # copy parameter by value
		self$.engine$tmp_message2 = message2; # copy parameter by value
			objId = self$.engine %~% '
				synchronized(objs) {
					objs[nextObjId] = new uk.co.terminological.mavenrjsr233plugintest.AnotherTestRApi(tmp_message1, tmp_message2);
					nextObjId = nextObjId+1 
				}
				return nextObjId-1;
			'
			# delete parameters
			self$.engine$remove("tmp_message1")
			self$.engine$remove("tmp_message2")
			return(AnotherTestRApi$new(self$.engine, objId))
		}	,
		create = function(message1, message2) {
			# copy parameters
			self$.engine$tmp_message1 = message1; # by value
			self$.engine$tmp_message2 = message2; # by value
			#execute static call
			# execute static method and return object by reference (always creates a new instance)   
			objId = self$.engine %~% '
				synchronized(objs) {
					objs[nextObjId] = uk.co.terminological.mavenrjsr233plugintest.AnotherTestRApi.create(tmp_message1, tmp_message2);
					nextObjId = nextObjId+1 
				}
				return nextObjId-1;
			'
			# wrap resulting id in R class - static methods always create instances
			out = AnotherTestRApi$new(self$.engine, objId)
			# delete parameters
			self$.engine$remove("tmp_message1")
			self$.engine$remove("tmp_message2")
			return(out)
		},
		concat = function(message1, message2) {
			# copy parameters
			self$.engine$tmp_message1 = message1; # by value
			self$.engine$tmp_message2 = message2; # by value
			#execute static call
			# execute static method and return object by value
			out = self$.engine %~% '
				return uk.co.terminological.mavenrjsr233plugintest.AnotherTestRApi.concat(tmp_message1, tmp_message2);
			'
			# delete parameters
			self$.engine$remove("tmp_message1")
			self$.engine$remove("tmp_message2")
			return(out)
		}	)
	}
))

## a generic catch all object reference for classes that cannot be mapped to and from Java.
Object = R6::R6Class("Object", public=list(
	.engine = NULL,
	.objId = NULL,
	initialize = function(engine,objectId){
		self$.engine = engine;
		self$.objId = objectId;
	},
	print = function() {
		self$.engine$tmp2_objId = self$.objId;
		out = self$.engine %~% '
			return objs[tmp2_objId].toString();
		'
		self$.engine$remove("tmp2_objId")
		print(out)
		invisible(self)
	}
))

TestRApi = R6::R6Class("TestRApi", public=list(
	.engine = NULL,
	.objId = NULL,
	initialize = function(engine,objectId){
		self$.engine = engine;
		self$.objId = objectId;
	},
	doHelloWorld = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].doHelloWorld();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	fluentSetMessage = function(message) {
		# copy parameters
		self$.engine$tmp_message = message; # pass parameter by value
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a new (or the same) objId by reference   
		objId = self$.engine %~% '
			def tmp = objs[tmp2_objId].fluentSetMessage(tmp_message);
			// if the result the same object as the original? e.g. a fluent method
			if (tmp.is(objs[tmp2_objId])) {
				return tmp2_objId; 
			} else {
				synchronized(objs) {
					objs[nextObjId] = tmp;
					nextObjId = nextObjId+1; 
				}
				return nextObjId-1;
			}
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_message")
		if (objId == self$.objId) {
			invisible(self) # e.g. a fluent method
		} else {
			out = TestRApi$new(self$.engine, objId)
			return(out)
		}
	},
	factoryMethod = function(a, b) {
		# copy parameters
		self$.engine$tmp_a = a; # pass parameter by value
		self$.engine$tmp_b = b; # pass parameter by value
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a new (or the same) objId by reference   
		objId = self$.engine %~% '
			def tmp = objs[tmp2_objId].factoryMethod(tmp_a, tmp_b);
			// if the result the same object as the original? e.g. a fluent method
			if (tmp.is(objs[tmp2_objId])) {
				return tmp2_objId; 
			} else {
				synchronized(objs) {
					objs[nextObjId] = tmp;
					nextObjId = nextObjId+1; 
				}
				return nextObjId-1;
			}
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_a")
		self$.engine$remove("tmp_b")
		if (objId == self$.objId) {
			invisible(self) # e.g. a fluent method
		} else {
			out = AnotherTestRApi$new(self$.engine, objId)
			return(out)
		}
	},
	getMessage = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].getMessage();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	doSum = function(a, b) {
		# copy parameters
		self$.engine$tmp_a = a; # pass parameter by value
		self$.engine$tmp_b = b; # pass parameter by value
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].doSum(tmp_a, tmp_b);
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_a")
		self$.engine$remove("tmp_b")
		return(out)
	},
	objectAsParameter = function(otherObj) {
		# copy parameters
		self$.engine %@% paste0('tmp_otherObj = objs[',otherObj$.objId,']'); # pass parameter by reference
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].objectAsParameter(tmp_otherObj);
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_otherObj")
		return(out)
	},
	fluentRandomObjectAsParamerer = function(file) {
		# copy parameters
		self$.engine %@% paste0('tmp_file = objs[',file$.objId,']'); # pass parameter by reference
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a new (or the same) objId by reference   
		objId = self$.engine %~% '
			def tmp = objs[tmp2_objId].fluentRandomObjectAsParamerer(tmp_file);
			// if the result the same object as the original? e.g. a fluent method
			if (tmp.is(objs[tmp2_objId])) {
				return tmp2_objId; 
			} else {
				synchronized(objs) {
					objs[nextObjId] = tmp;
					nextObjId = nextObjId+1; 
				}
				return nextObjId-1;
			}
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_file")
		if (objId == self$.objId) {
			invisible(self) # e.g. a fluent method
		} else {
			out = Object$new(self$.engine, objId)
			return(out)
		}
	},
	doSomethingWithDataFrame = function(colMajorDf) {
		# copy parameters
		self$.engine$tmp_colMajorDf = colMajorDf; # pass parameter by value
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a new (or the same) objId by reference   
		objId = self$.engine %~% '
			def tmp = objs[tmp2_objId].doSomethingWithDataFrame(tmp_colMajorDf);
			// if the result the same object as the original? e.g. a fluent method
			if (tmp.is(objs[tmp2_objId])) {
				return tmp2_objId; 
			} else {
				synchronized(objs) {
					objs[nextObjId] = tmp;
					nextObjId = nextObjId+1; 
				}
				return nextObjId-1;
			}
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_colMajorDf")
		invisible(NULL)
	},
	doSomethingWithOtherDataFrame = function(rowMajorDf) {
		# copy parameters
		self$.engine %@% paste0('tmp_rowMajorDf = objs[',rowMajorDf$.objId,']'); # pass parameter by reference
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a new (or the same) objId by reference   
		objId = self$.engine %~% '
			def tmp = objs[tmp2_objId].doSomethingWithOtherDataFrame(tmp_rowMajorDf);
			// if the result the same object as the original? e.g. a fluent method
			if (tmp.is(objs[tmp2_objId])) {
				return tmp2_objId; 
			} else {
				synchronized(objs) {
					objs[nextObjId] = tmp;
					nextObjId = nextObjId+1; 
				}
				return nextObjId-1;
			}
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		self$.engine$remove("tmp_rowMajorDf")
		invisible(NULL)
	},
	generateRowMajorDataFrame = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].generateRowMajorDataFrame();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	generateColMajorDataFrame = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].generateColMajorDataFrame();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	generateColMajorDataFrame2 = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return (List<Map<String,Object>>) objs[tmp2_objId].generateColMajorDataFrame2();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	print = function() {
		self$.engine$tmp2_objId = self$.objId;
		out = self$.engine %~% '
			return objs[tmp2_objId].toString();
		'
		self$.engine$remove("tmp2_objId")
		print(out)
		invisible(self)
	}
))

AnotherTestRApi = R6::R6Class("AnotherTestRApi", public=list(
	.engine = NULL,
	.objId = NULL,
	initialize = function(engine,objectId){
		self$.engine = engine;
		self$.objId = objectId;
	},
	throwCatchable = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].throwCatchable();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	printMessage = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a new (or the same) objId by reference   
		objId = self$.engine %~% '
			def tmp = objs[tmp2_objId].printMessage();
			// if the result the same object as the original? e.g. a fluent method
			if (tmp.is(objs[tmp2_objId])) {
				return tmp2_objId; 
			} else {
				synchronized(objs) {
					objs[nextObjId] = tmp;
					nextObjId = nextObjId+1; 
				}
				return nextObjId-1;
			}
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		invisible(NULL)
	},
	throwRuntime = function() {
		# copy parameters
		self$.engine$tmp2_objId = self$.objId;
		#execute call on instance .objId returning a result by value
		out = self$.engine %~% '
			return  objs[tmp2_objId].throwRuntime();
		'
		# delete parameters
		self$.engine$remove("tmp2_objId")
		return(out)
	},
	print = function() {
		self$.engine$tmp2_objId = self$.objId;
		out = self$.engine %~% '
			return objs[tmp2_objId].toString();
		'
		self$.engine$remove("tmp2_objId")
		print(out)
		invisible(self)
	}
))

