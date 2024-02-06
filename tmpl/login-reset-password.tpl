<!--include[header]-->


<div class="main-section">

    <br/>
    <br/>
    <br/>
    <br/>
    <br/>

    <main class="main-content">

        <div class="left">
            
            <div>
                <h1 class="title underline">Reset my password</h2>
                <br/>
                <br/>
                <div class="section page">

                    <form method="post" action="/reset-password" class="login-form">
                        <div class="error"><!--[login.error]--></div>
                        <label for="email">Email:</label><br/>
                        <input type="email" name="email" id="email" placeholder="Email address" value="<!--[login.email]-->"/>
                        <br/>
                        <span <!--[login.otp.visibility]-->>
                            <label for="otp">OTP:</label><br/>
                            <input type="text" name="otp" id="otp" placeholder="Enter the OTP from your email address"/>
                        </span>
                        <br/>
                        <br/>
                        <input type="submit" name="reset" value="Reset password" class="button"/>

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