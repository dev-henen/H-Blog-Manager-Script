<!--include[header]-->


<div class="main-section">

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

    <main class="main-content">

        <div class="left">
            
            <div>
                <h1 class="title underline">Login</h2>
                <br/>
                <br/>
                <div class="section page">

                    <form method="post" action="/login" class="login-form">
                        <div class="error"><!--[login.error]--></div>
                        <label for="email">Email:</label><br/>
                        <input type="email" name="email" id="email" placeholder="Email address" value="<!--[login.email]-->"/>
                        <br/>
                        <label for="password">Password:</label><br/>
                        <input type="password" name="password" id="password" placeholder="Password" autocomplete="off"/>
                        <p>
                            Forgot password? 
                            <a href="/reset-password">Reset my password</a>
                        </p>
                        <br/>
                        <br/>
                        <input type="submit" name="login" value="Login" class="button"/>

                        <br/>
                        <br/>


                    </form>
                    <br/>
                    <br/>

                </div>
                

            </div>

            <br/>
            <br/>


            
        </div>
        <div class="right">

            <br/>
            <br/>

   
        </div>

    </main>


</div>

<!--include[footer]-->