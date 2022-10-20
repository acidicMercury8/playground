using Microsoft.AspNetCore.Mvc;

using SwaggerWebApplication.Models;

namespace SwaggerWebApplication.Controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class TodoController : ControllerBase {
    // GET: api/<TodoController>
    [HttpGet]
    public IEnumerable<string> Get() {
        return new string[] { "value1", "value2" };
    }

    //// GET api/<TodoController>/5
    //[HttpGet("{id}")]
    //public string Get(int id) {
    //    return "value";
    //}

    //// POST api/<TodoController>
    //[HttpPost]
    //public void Post([FromBody] string value) {
    //}

    //// PUT api/<TodoController>/5
    //[HttpPut("{id}")]
    //public void Put(int id, [FromBody] string value) {
    //}

    //// DELETE api/<TodoController>/5
    //[HttpDelete("{id}")]
    //public void Delete(int id) {
    //}

    /// <summary>
    /// Deletes a specific TodoItem
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(long id) {
        //var item = await _context.TodoItems.FindAsync(id);

        //if (item is null) {
        //    return NotFound();
        //}

        //_context.TodoItems.Remove(item);
        //await _context.SaveChangesAsync();

        return NoContent();
    }

    /// <summary>
    /// Creates a TodoItem.
    /// </summary>
    /// <param name="item"></param>
    /// <returns>A newly created TodoItem</returns>
    /// <remarks>
    /// Sample request:
    ///
    ///     POST /Todo
    ///     {
    ///        "id": 1,
    ///        "name": "Item #1",
    ///        "isComplete": true
    ///     }
    ///
    /// </remarks>
    /// <response code="201">Returns the newly created item</response>
    /// <response code="400">If the item is null</response>
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Create(TodoItem item) {
        //_context.TodoItems.Add(item);
        //await _context.SaveChangesAsync();

        return CreatedAtAction(nameof(Get), new { id = item.Id }, item);
    }
}
