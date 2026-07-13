**Fast-Proxy-Checker**

> A high-performance tool for checking the validity of a large list of
> proxy servers.
>
> **Features**
>
> • **Fast and Efficient:** Optimized for speed to process thousands of
> proxies quickly.
>
> • **Multiple Protocols:** Supports HTTP, HTTPS, and SOCKS proxies.•
> **Customizable Timeout:** Set your desired timeout for each proxy
> check.
>
> **Concurrent Checks:** Utilizes multi-threading for parallel proxy
> validation.•\
> • **Clear Output:** Generates a CSV file with valid proxies and their
> details.
>
> • **Environment Variable Authentication:** Securely manage API keys or
> credentials.
>
> **Requirements**
>
> • Python 3.7+

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: right;">•</th>
<th style="text-align: left;"><blockquote>
<p>requests library</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: right;">•</td>
<td style="text-align: left;"><blockquote>
<p>multiprocessing (built-in)</p>
</blockquote></td>
</tr>
</tbody>
</table>

> **Installation**
>
> 1\. **Clone the repository:**bash git clone https://github.com/
>
> your_username/Fast-Proxy-Checker.git cd Fast-Proxy-

| Checker |
|---------|

> 2\. **Install dependencies:**bash pip install -r requirements.txt
>
> **Proxy List Format (hosts.txt)**
>
> Create a file named hosts.txt in the root directory of the project.
> Each line should contain a proxy in the following format:

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>&lt;ip_address&gt;:&lt;port&gt;</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> For SOCKS proxies, you can optionally specify the protocol:

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>socks4://&lt;ip_address&gt;:&lt;port&gt;</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>socks5://&lt;ip_address&gt;:&lt;port&gt;</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> **Usage**
>
> Run the script from your terminal:

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>python proxy_checker.py --file hosts.txt --output valid_proxies.csv
--</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> **Arguments:**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: right;">•</th>
<th style="text-align: left;"><blockquote>
<p>--file (required): Path to the proxy list file (e.g., hosts.txt).</p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: right;">•</td>
<td style="text-align: left;"><blockquote>
<p>--output (required): Path to the output CSV file for valid proxies
(e.g.,</p>
</blockquote></td>
</tr>
</tbody>
</table>

> valid_proxies.csv).

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: right;">•</th>
<th style="text-align: left;"><blockquote>
<p>--timeout (optional): Timeout in seconds for each proxy check.</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> Defaults to 10.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: right;">•</th>
<th style="text-align: left;"><blockquote>
<p>--threads (optional): Number of concurrent threads to use. Defaults
to</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> 10\.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: right;">•</th>
<th style="text-align: left;"><blockquote>
<p>--url (optional): A target URL to test proxy connectivity. Defaults
to</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>https://httpbin.org/ip.</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> **Authentication via Env Vars**
>
> Some proxy services might require authentication (e.g., API keys). You
> can set these as environment variables. For example, if a proxy
> requires an API key, you might set an environment variable like:

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>export PROXY_API_KEY="your_api_key_here"</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> The script can then access this variable using\
> os.environ.get('PROXY_API_KEY'). Refer to the script's code for
> specific environment variable names used.
>
> **Output (csv)**
>
> The script will generate a CSV file specified by the --output
> argument. The file will contain lines for each valid proxy, with
> columns such as:

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr>
<th style="text-align: right;">•</th>
<th><table style="width:65%;">
<colgroup>
<col style="width: 65%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;">ip_address</th>
</tr>
</thead>
<tbody>
</tbody>
</table></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: right;">•</td>
<td><table style="width:65%;">
<colgroup>
<col style="width: 65%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;">port</th>
</tr>
</thead>
<tbody>
</tbody>
</table></td>
</tr>
<tr>
<td style="text-align: right;">•</td>
<td><table style="width:65%;">
<colgroup>
<col style="width: 65%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;">protocol</th>
</tr>
</thead>
<tbody>
</tbody>
</table></td>
</tr>
<tr>
<td style="text-align: right;">•</td>
<td style="text-align: left;"><blockquote>
<p>response_time (in seconds)</p>
</blockquote></td>
</tr>
</tbody>
</table>

> **Security Notes**
>
> • **Never share your proxy credentials or API keys publicly.**
>
> • **Be mindful of the proxies you check.** Some public proxies may be
> malicious or used for illicit activities.
>
> • **The url argument:** Using a reliable and known URL is recommended
> for testing. Avoid testing against sensitive or private endpoints.
>
> **Project Structure**

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>.</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>├── proxy_checker.py</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>├── hosts.txt # Example proxy list</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>├── requirements.txt</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>├── README.md</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

<table>
<colgroup>
<col style="width: 100%" />
</colgroup>
<thead>
<tr>
<th style="text-align: left;"><blockquote>
<p>└── output.csv # Example output file</p>
</blockquote></th>
</tr>
</thead>
<tbody>
</tbody>
</table>

> **License**
>
> \[LICENSE PLACEHOLDER\]
